From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 3 Jan 2012 20:45:02 +0800
Subject: [PATCH] ARM: imx6q: add support for IRAM
In-Reply-To: <1324898123-13973-1-git-send-email-jason.chen@linaro.org>
References: <1324898123-13973-1-git-send-email-jason.chen@linaro.org>
Message-ID: <20120103124501.GD13477@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 26, 2011 at 07:15:23PM +0800, Jason Chen wrote:
> +DEF_CLK(ocram_clk,   	  CCGR3, CG14, &ahb_clk,	  NULL);

  CC      arch/arm/mach-imx/clock-imx6q.o
arch/arm/mach-imx/clock-imx6q.c:1782:1: warning: ?ocram_clk? defined but not used

-- 
Regards,
Shawn
