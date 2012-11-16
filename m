From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 16 Nov 2012 22:25:32 +0800
Subject: [PATCH 2/2] ARM: dts: cfa10049: Add the i2c muxer buses to the
 CFA-10049
In-Reply-To: <20121116083218.GE8464@pengutronix.de>
References: <1351182234-22971-1-git-send-email-maxime.ripard@free-electrons.com>
 <1351182234-22971-3-git-send-email-maxime.ripard@free-electrons.com>
 <20121116083218.GE8464@pengutronix.de>
Message-ID: <20121116142530.GH2941@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2012 at 09:32:18AM +0100, Wolfram Sang wrote:
> On Thu, Oct 25, 2012 at 06:23:54PM +0200, Maxime Ripard wrote:
> > This will allow to add the 3 Nuvoton NAU7802 ADCs and the NXP PCA9555
> > GPIO expander eventually.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Shawn, I pushed the needed code to my for-next now. So you could apply
> this patch for 3.8 or give an ack in case you want me to pick it via
> i2c.
> 
I have already sent mxs 3.8 stuff to arm-soc, so please have it go via
i2c tree.  Thanks.

Acked-by: Shawn Guo <shawn.guo@linaro.org>
