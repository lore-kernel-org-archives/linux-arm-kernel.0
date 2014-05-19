From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 19 May 2014 14:47:02 +0800
Subject: [PATCH 1/2 v4] ARM: imx: fix error handling in ipu device
 registration
In-Reply-To: <20140519063145.GF16662@pengutronix.de>
References: <1400446261-27085-1-git-send-email-emilgoode@gmail.com>
 <1400446261-27085-2-git-send-email-emilgoode@gmail.com>
 <20140519063145.GF16662@pengutronix.de>
Message-ID: <20140519064701.GK10685@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 19, 2014 at 08:31:45AM +0200, Uwe Kleine-K?nig wrote:
> On Sun, May 18, 2014 at 10:50:59PM +0200, Emil Goode wrote:
> > If we fail to allocate struct platform_device pdev we
> > dereference it after the goto label err.
> > 
> > This bug was found using coccinelle.
> > 
> > Signed-off-by: Emil Goode <emilgoode@gmail.com>
> Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> 
> Shawn, is it already to late for 3.15?

Let me try to see.

Shawn
