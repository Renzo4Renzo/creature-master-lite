import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';
import * as bcrypt from 'bcrypt';

@Injectable()
export class PlayerService {
  constructor(private prisma: PrismaService) {}

  async registerPlayer(username: string, email: string, password: string) {
    const hashedPassword = await bcrypt.hash(password, 10);
    return this.prisma.player.create({
      data: {
        username,
        email,
        password: hashedPassword,
      },
    });
  }
}
