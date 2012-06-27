From: marex@denx.de (Marek Vasut)
Date: Wed, 27 Jun 2012 03:30:31 +0200
Subject: [PATCH 1/2 V3] MXS: Set I2C timing registers for mxs-i2c
In-Reply-To: <201206111254.21766.marex@denx.de>
References: <1339242351-8797-1-git-send-email-marex@denx.de>
 <20120611063903.GD2552@S2101-09.ap.freescale.net>
 <201206111254.21766.marex@denx.de>
Message-ID: <201206270330.31669.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> > On Sat, Jun 09, 2012 at 01:45:50PM +0200, Marek Vasut wrote:
> > > This patch configures the I2C bus timing registers according
> > > to information passed via DT. Currently, 100kHz and 400kHz
> > > modes are supported.
> > > 
> > > Signed-off-by: Marek Vasut <marex@denx.de>
> > 
> > I gave it a test on imx28-evk board with audio playback.  It seems
> > the patch makes the first time playback non-functional, but the later
> > playback is still working.
> 
> Any hints what can be the source of this issue? I tested it with i2c
> eeprom, saw no issues in there. I'll poke into it later.

Ok, I managed to replicate it just now. Scrap my previous email.

Still, any idea what can cause this?

Best regards,
Marek Vasut
