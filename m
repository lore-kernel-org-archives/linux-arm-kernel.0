From: san.mlists@gmail.com (Santhosh N)
Date: Thu, 23 Sep 2010 11:03:05 +0530
Subject: PXA270 audio problem
Message-ID: <AANLkTi=_AANevVpthOKuRfkkvU9mKMWsmpHc+XohoUwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear All,

I am running linux 2.6.26 kernel on a PXA270 board. A UCB1400 chip
used for audio and touchscreen in that. I have been facing a problem
with audio.

The audio plays properly, but suddenly stops. I get the following message:
ALSA sound/core/pcm_native.c:1513: playback drain error (DMA or IRQ trouble?)

I have noticed that the DMA interrupts stop coming. Where as the AC97
interrupts come properly.

Any help in solving this will be grateful.

Regards,
Santhosh N
