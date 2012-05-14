From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 14 May 2012 17:46:07 +0800
Subject: [PATCH 3/5] ARM: imx: add audio codec clk lookup for imx53-qsb
In-Reply-To: <20120514085348.GB30400@pengutronix.de>
References: <1336718568-26810-1-git-send-email-shawn.guo@linaro.org>
 <1336718568-26810-4-git-send-email-shawn.guo@linaro.org>
 <20120514082201.GF21318@pengutronix.de>
 <20120514085002.GE20367@S2100-06.ap.freescale.net>
 <20120514085348.GB30400@pengutronix.de>
Message-ID: <20120514094606.GG20367@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2012 at 10:53:48AM +0200, Sascha Hauer wrote:
> I hope we won't get to that point. The above should be really in the
> devicetree, right?

If you are talking about that clk lookup, yes, the board specific clk
lookup is the best candidate going into device tree.

-- 
Regards,
Shawn
