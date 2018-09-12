From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Wed, 12 Sep 2018 09:33:55 +0200
Subject: [PATCH v12 0/6] Driver for at91 usart in spi mode
In-Reply-To: <20180911225440.GL4185@dell>
References: <20180904111310.4049-1-radu_nicolae.pirea@upb.ro>
 <20180911093356.GE4185@dell> <20180911093917.GL2494@piout.net>
 <CAMuHMdXH8gNjKGOHGFc+K03U2zsVCSN7G_Q4wtepQr859nRQKg@mail.gmail.com>
 <20180911153621.GP2494@piout.net>
 <CAMuHMdV+=EgAYogwNHbY=RExkGox_+YSeHV6pJtQb6g6PzD-CQ@mail.gmail.com>
 <20180911181838.GI4185@dell> <20180911185839.GA25212@piout.net>
 <20180911224418.GK4185@dell> <20180911225440.GL4185@dell>
Message-ID: <20180912073355.GB2557@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/09/2018 23:54:40+0100, Lee Jones wrote:
> > > http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-6438-32-bit-ARM926-Embedded-Microprocessor-SAM9G45_Datasheet.pdf
> > > 
> > > USART doc starting p572, registers p621.
> 
> After looking at the datasheet, I don't see any reason why one of the
> two drivers can't be selected using different compatible strings.

Because there is only one IP and we don't use the device tree to selecet
linux specific drivers.

If you are not happy having that in MFD, I guess we can move it out
somewhere else.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
