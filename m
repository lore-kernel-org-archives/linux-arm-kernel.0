From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 May 2013 20:51:12 +0800
Subject: [PATCH 2/3] ARM: imx: move clk_prepare() out from mxs_restart()
In-Reply-To: <20130513082535.GM32299@pengutronix.de>
References: <1368408728-12264-1-git-send-email-shawn.guo@linaro.org>
 <1368408728-12264-3-git-send-email-shawn.guo@linaro.org>
 <20130513082535.GM32299@pengutronix.de>
Message-ID: <20130513125111.GB4440@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 13, 2013 at 10:25:35AM +0200, Sascha Hauer wrote:
> Hi Shawn,
> 
> In the subject:
> 
> s/mxs_restart/mxc_restart/

Thanks, Sascha.  Fixed it and commit log as well.

Shawn
