From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 24 Dec 2013 16:22:54 +0800
Subject: [PATCH] ARM: imx: add necessary interface for pfd
In-Reply-To: <1387911938-4828-1-git-send-email-b20788@freescale.com>
References: <1387911938-4828-1-git-send-email-b20788@freescale.com>
Message-ID: <20131224082252.GG3872@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 24, 2013 at 02:05:38PM -0500, Anson Huang wrote:
> Common clk framework will disable unused clks in late init only if
> they are enabled by default and no one is using it, so we need to
> add is_enabled callback for clk framework to get clks' status.
> 
> PFD clocks are enabled by hardware reset, so we need to add
> interface for common clk framework to disable those unused ones for
> saving power.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>

Applied, thanks. 
