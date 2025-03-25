import { Module } from '@nestjs/common';
import { WebsocketGateway } from './websocket.gateway';
import { WebSocketService } from './websocket.service';
import { RedisModule } from 'src/redis/redis.module';

@Module({
  imports: [RedisModule], // Connect to Redis
  providers: [WebsocketGateway, WebSocketService],
})
export class WebSocketModule {}
