import { Body, Controller, Post } from '@nestjs/common';
import { PlayerService } from './player.service';

@Controller('players')
export class PlayerController {
  constructor(private playerService: PlayerService) {}

  @Post('register')
  async registerPlayer(
    @Body() body: { username: string; email: string; password: string },
  ) {
    return this.playerService.registerPlayer(
      body.username,
      body.email,
      body.password,
    );
  }
}
