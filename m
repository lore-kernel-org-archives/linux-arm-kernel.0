From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 24 Nov 2011 16:24:51 +0800
Subject: [PATCH] i2c-mxs: fix compile warning in mxs_i2c_xfer()
In-Reply-To: <20111124080004.GD8439@pengutronix.de>
References: <1322121140-5216-1-git-send-email-shawn.guo@linaro.org>
 <20111124080004.GD8439@pengutronix.de>
Message-ID: <20111124082450.GB18060@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2011 at 09:00:04AM +0100, Wolfram Sang wrote:
> On Thu, Nov 24, 2011 at 03:52:20PM +0800, Shawn Guo wrote:
> >   CC      drivers/i2c/busses/i2c-mxs.o
> > drivers/i2c/busses/i2c-mxs.c: In function ?mxs_i2c_xfer?:
> > drivers/i2c/busses/i2c-mxs.c:196:6: warning: ?data? may be used uninitialized in this function
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> 
> Which compiler? What flags? I don't see that here.
> 
gcc version 4.5.2 (Ubuntu/Linaro 4.5.2-8ubuntu3)

$ make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- -j 2 zImage

-- 
Regards,
Shawn
