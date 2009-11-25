From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 25 Nov 2009 13:14:22 +0100
Subject: ARM: pxa: add support for Raumfeld audio devices
In-Reply-To: <4B0D14B8.1000207@compulab.co.il>
References: <1259145751-3331-1-git-send-email-daniel@caiaq.de>
	<4B0D14B8.1000207@compulab.co.il>
Message-ID: <20091125121421.GH29442@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2009 at 01:27:52PM +0200, Mike Rapoport wrote:
> Daniel Mack wrote:
> > [PATCH 01/17] ARM: pxa/raumfeld: add basic structure for devices
> > [PATCH 02/17] ARM: pxa/raumfeld: add GPIO definitions
> > [PATCH 03/17] ARM: pxa/raumfeld: add SMSC9220 ethernet support
> > [PATCH 04/17] ARM: pxa/raumfeld: add OHCI function
> > [PATCH 05/17] ARM: pxa/raumfeld: add rotary encoder support
> > [PATCH 06/17] ARM: pxa/raumfeld: add GPIO buttons
> > [PATCH 07/17] ARM: pxa/raumfeld: add GPIO connected LEDs
> > [PATCH 08/17] ARM: pxa/raumfeld: add one-wire function
> > [PATCH 09/17] ARM: pxa/raumfeld: add NAND partitions
> > [PATCH 10/17] ARM: pxa/raumfeld: add framebuffer and backlight devices
> > [PATCH 11/17] ARM: pxa/raumfeld: add SPI controlled devices
> > [PATCH 12/17] ARM: pxa/raumfeld: add audio related functions
> > [PATCH 13/17] ARM: pxa/raumfeld: add Marvell Libertas via SDIO
> > [PATCH 14/17] ARM: pxa/raumfeld: add power supply framework
> > [PATCH 15/17] ARM: pxa/raumfeld: add support for I2C controlled devices
> > [PATCH 16/17] ALSA: ARM: add Raumfeld audio support
> > [PATCH 17/17] ARM: pxa/raumfeld: Add defconfig
> 
> I don't know what about others, but I find it difficult to follow too many small
> patches. I'd personally prefer to have
> "[PATCH 1/2] ARM: pxa: add raumfeld board support"
> "[PATCH 1/2] ARM: pxa/raumfeld: add defconfig"
> 
> Once again, it's my personal preference :)

Well, I was told it is a lot easier to review patches when they're
split up in smaller pieces. However, I would be fine if they are
squashed when merged :)

Daniel
