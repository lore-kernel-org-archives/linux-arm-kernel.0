From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 Jan 2012 12:30:37 +0000
Subject: [PATCH] RFC: spi/sa1100: rewrite the SA1100 SPI driver
In-Reply-To: <CACRpkdbynmvcjOY=7_6wK3YTJHpS16Y0fU-Ka3-qw6Vt+eXy0A@mail.gmail.com>
References: <1326841236-25178-1-git-send-email-linus.walleij@linaro.org>
 <20120117231314.GA1068@n2100.arm.linux.org.uk>
 <CACRpkdbynmvcjOY=7_6wK3YTJHpS16Y0fU-Ka3-qw6Vt+eXy0A@mail.gmail.com>
Message-ID: <20120118123037.GF1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2012 at 01:13:29PM +0100, Linus Walleij wrote:
> On Wed, Jan 18, 2012 at 12:13 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> 
> > Please don't delete the above definitions.
> 
> OK don't want to break anything...
> 
> > The SSP interface is more than just SPI (it's microwire and TI format,
> > and I have a working ASoC driver for the Assabet.)
> 
> We usually merge drivers for microwire, TI, Motorola ... etc into
> drivers/spi as well. It's a good enough fit, the differences are very
> small. This is how we configure mode from the PL022 driver platform data:

How do you send audio data at 16-bit 2 channel 48kHz continuously with
the SPI subsystem?
