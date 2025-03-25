import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { PlayerModule } from './player/player.module';
import { WebSocketModule } from './websocket/websocket.module';
import { RedisModule } from './redis/redis.module';

@Module({
  imports: [PlayerModule, WebSocketModule, RedisModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
