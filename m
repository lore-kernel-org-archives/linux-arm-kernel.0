From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 26 Nov 2013 22:33:00 +0800
Subject: [PATCH v2 1/2] can + ARM i.MX53: use 24 MHz clock parent on i.MX53
In-Reply-To: <52945B40.5020200@pengutronix.de>
References: <1385414121-21493-1-git-send-email-mkl@pengutronix.de>
 <20131126045340.GJ30476@S2101-09.ap.freescale.net>
 <52945B40.5020200@pengutronix.de>
Message-ID: <20131126143258.GA5685@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 26, 2013 at 09:26:40AM +0100, Marc Kleine-Budde wrote:
> The problem is, that the wrong clock is being used. An all i.mx, but not
> on imx6, both clocks are the same, the bug doesn't show up. So before we
> can use the 24 MHz clock on mx53, we have to fix the driver.

So it sounds like a more appropriate merging path would be that,
you send the driver fix right away to mainline via net tree with
v3.13-rc series, and I rebase IMX tree on the -rc that has the fix,
and then apply the DTS patch.

Shawn
