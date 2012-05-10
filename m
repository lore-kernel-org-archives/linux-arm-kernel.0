From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 10 May 2012 15:35:20 +0800
Subject: [PATCH 0/4] MXS: I2C improvements
In-Reply-To: <201205092033.46812.marex@denx.de>
References: <1335837621-14816-1-git-send-email-marex@denx.de>
 <201205092033.46812.marex@denx.de>
Message-ID: <20120510073518.GE17875@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2012 at 08:33:46PM +0200, Marek Vasut wrote:
> > This patchset implements support for adjustment of I2C bus speed via
> > platform data. Further, it implements support for DMA transfers into the
> > mxs-i2c driver. Lastly, there is a fix for GCC4.7 warning included.
> > 
> > Marek Vasut (4):
> >   MXS: Allow passing i2c bus speed via platform data
> >   MXS: Set I2C timing registers for mxs-i2c
> >   MXS: Implement DMA support into mxs-i2c
> >   MXS: Fix GCC4.7 complaint in mxs-i2c
> 
> Bump?
> 
Sorry, Marek.  Since we are moving over to device tree, I'm not going
to ack the arch/arm/mach-mxs changes, which are introducing more use
of platform data.

-- 
Regards,
Shawn
