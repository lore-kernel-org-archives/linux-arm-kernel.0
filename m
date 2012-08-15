From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 15 Aug 2012 23:06:21 +0800
Subject: [PATCH] ARM i.MX6q: Add virtual 1/3.5 dividers in the LDB clock
 path
In-Reply-To: <1345024816-6368-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1345024816-6368-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <20120815150619.GF2258@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 15, 2012 at 12:00:16PM +0200, Steffen Trumtrar wrote:
> From: Philipp Zabel <p.zabel@pengutronix.de>
> 
> The ldb_di[01]_podf is implemented as a clk-divider that
> divides by 1 or 2. In reality, the ldb_di[01]_ipu_div
> dividers divide by either 3.5 or 7. Adding a fixed factor
> of 1/3.5 fixes their children's clock rates.
> 
> This should probably be converted to rate table based dividers,
> once available.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>

Applied this as a fix with stable Cc-ed.  Let me know if this is
inappropriate.

-- 
Regards,
Shawn
