From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Wed, 14 Mar 2012 15:34:55 +0800
Subject: [PATCH v1 0/5] dt: add basic imx28 support
In-Reply-To: <201203140701.07111.marek.vasut@gmail.com>
References: <1331628428-24017-1-git-send-email-b29396@freescale.com>
 <201203140701.07111.marek.vasut@gmail.com>
Message-ID: <20120314073454.GD8494@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 14, 2012 at 07:01:06AM +0100, Marek Vasut wrote:
> Dear Dong Aisheng,
> 
> > This patch series adds basic imx28 dt support including fec, mmc and dma.
> > 
> > Tested on mx28evk.
> > 
> > TODO:
> > Convert the remaining devices to support dt.
> > mxs-auart, mxs-gpio, i2c, flexcan, saif, rtc, pwm, fb.
> > 
> > Dong Aisheng (5):
> >   ARM: imx28: add basic dt support
> >   mmc: mxs-mmc: add dt probe support
> >   ARM: imx28evk: add mmc dt support
> >   dma: mxs-dma: add dt probe support
> >   ARM: mxs: add mxs dma dt support
> > 
> Can you keep me in Cc on new versions of these patches? Thanks!
> 
Of course yes.
Thanks for your review.

Regards
Dong Aisheng
