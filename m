From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 22 Nov 2012 14:23:25 +0800
Subject: [PATCH v3] ARM: mx5: Replace clk_register_clkdev with clock DT
 lookup
In-Reply-To: <1353512585-29458-1-git-send-email-fabio.estevam@freescale.com>
References: <1353512585-29458-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20121122062322.GC24693@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2012 at 01:43:05PM -0200, Fabio Estevam wrote:
> Similarly as it was done for mx6q, use a DT lookup in order to make maintainance
> task for the clock devices easier.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
