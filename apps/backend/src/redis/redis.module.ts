import { Module } from '@nestjs/common';
import { RedisService } from './redis.service';

@Module({
  providers: [RedisService],
  exports: [RedisService], // Allows other modules (like WebSockets) to use it
})
export class RedisModule {}
