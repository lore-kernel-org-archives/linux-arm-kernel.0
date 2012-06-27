From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 27 Jun 2012 16:56:02 +0800
Subject: [PATCH 1/2] net: flexcan: clock-frequency is optional for device
 tree probe
In-Reply-To: <4FEAC89C.3000405@pengutronix.de>
References: <1340700563-8386-1-git-send-email-shawn.guo@linaro.org>
 <1340700563-8386-2-git-send-email-shawn.guo@linaro.org>
 <4FEAC89C.3000405@pengutronix.de>
Message-ID: <20120627085600.GB9787@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 27, 2012 at 10:47:24AM +0200, Marc Kleine-Budde wrote:
> On 06/26/2012 10:49 AM, Shawn Guo wrote:
> > The property clock-frequency is optional for device tree probe.  When
> > it's absent, the flexcan driver will try to get the frequency from clk
> > system by calling clk_get_rate.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

Thanks.

> 
> As Oliver pointed out, this doesn't go through the net tree.
> 
>From what I have seen, device tree maintainers are generally fine with
having binding document updates go through subsystem tree.

-- 
Regards,
Shawn
