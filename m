From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 23 Aug 2013 20:09:39 +0800
Subject: [PATCH] pinctrl: imx: Fix compilation with DEBUG enabled
In-Reply-To: <1377247137-19582-1-git-send-email-s.hauer@pengutronix.de>
References: <1377247137-19582-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20130823120937.GB10662@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 23, 2013 at 10:38:57AM +0200, Sascha Hauer wrote:
> This became broken with converting the pinmux arrays into struct
> types. While at it replace the preprocessor magic with a simple
> dev_dbg.
> 
> Reported-by: Tushar Behera <tushar.behera@linaro.org>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
