import {
  ConnectedSocket,
  MessageBody,
  OnGatewayConnection,
  OnGatewayDisconnect,
  SubscribeMessage,
  WebSocketGateway,
  WebSocketServer,
} from '@nestjs/websockets';
import { Server, Socket } from 'socket.io';
import { RedisService } from 'src/redis/redis.service';
import { WebSocketService } from './websocket.service';

@WebSocketGateway({
  cors: {
    origin: '*', //TODO: Change this to the frontend URL
  },
})
export class WebsocketGateway
  implements OnGatewayConnection, OnGatewayDisconnect
{
  @WebSocketServer()
  private server: Server;

  constructor(
    private readonly websocketService: WebSocketService,
    private readonly redisService: RedisService,
  ) {}

  async afterInit() {
    this.websocketService.setServer(this.server);

    //Listen for Redis messages and send them to players
    this.redisService.subscribe('move-update', (data) => {
      this.websocketService.sendToRoom(
        `game-${data.gameId}`,
        'moveUpdate',
        data,
      );
    });
  }

  handleConnection(client: Socket) {
    console.log(`✅ Client connected: ${client.id}`);
  }

  handleDisconnect(client: Socket) {
    console.log(`❌ Client disconnected: ${client.id}`);
  }

  @SubscribeMessage('message')
  handleJoinGame(
    @MessageBody() data: { playerId: string },
    @ConnectedSocket() client: Socket,
  ) {
    console.log(`🎮 Player ${data.playerId} joined the game`);
    client.join(`game-${data.playerId}`);
    return { event: 'joined', data };
  }

  @SubscribeMessage('sendMove')
  async handlePlayerMove(
    @MessageBody() data: { gameId: string; move: string },
  ) {
    console.log(`Move received: ${data.move}`);

    // Publish move to Redis (so all instances process it)
    await this.redisService.publish('move-update', data);

    // Send move to the local WebSocket instance
    this.websocketService.sendToRoom(`game-${data.gameId}`, 'moveUpdate', data);
  }
}
