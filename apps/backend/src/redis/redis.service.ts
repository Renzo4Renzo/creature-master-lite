import { Injectable, OnModuleInit } from '@nestjs/common';
import Redis from 'ioredis';

@Injectable()
export class RedisService implements OnModuleInit {
  private publisher: Redis;
  private subscriber: Redis;
  private eventHandlers = new Map<string, (data: any) => void>();

  async onModuleInit() {
    const redisUrl = process.env.REDIS_URL;
    if (!redisUrl) {
      throw new Error('REDIS_URL environment variable is not defined');
    }

    this.publisher = new Redis(redisUrl);
    this.subscriber = new Redis(redisUrl);

    this.subscriber.on('message', (channel, message) => {
      const data = JSON.parse(message);
      const handler = this.eventHandlers.get(channel);
      if (handler) {
        handler(data);
      }
    });

    await this.subscriber.subscribe('game-events');
  }

  async publish(event: string, payload: any) {
    await this.publisher.publish(
      'game-events',
      JSON.stringify({ event, payload }),
    );
  }

  subscribe(event: string, handler: (data: any) => void) {
    this.eventHandlers.set(event, handler);
  }
}
