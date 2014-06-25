From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 26 Jun 2014 00:11:05 +0800
Subject: [PATCH v2] ARM: clk-imx51-imx53: Remove clk_register_clkdev()
In-Reply-To: <1403635378-17511-1-git-send-email-festevam@gmail.com>
References: <1403635378-17511-1-git-send-email-festevam@gmail.com>
Message-ID: <20140625161104.GK2224@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 24, 2014 at 03:42:58PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> mx51 and mx53 are device tree only platforms, so we no longer need all these
> calls to clk_register_clkdev().
> 
> Only keep cpu0 and gpc_dvfs clk_register_clkdev() calls.
> 
> Tested on imx51-babbage and imx53-qsb boards.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.
