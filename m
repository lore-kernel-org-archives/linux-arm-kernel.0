From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 27 May 2013 15:16:38 +0800
Subject: [PATCH 1/2] ARM: imx: irq-common: Include header to avoid sparse
 warning
In-Reply-To: <1369425342-20153-1-git-send-email-festevam@gmail.com>
References: <1369425342-20153-1-git-send-email-festevam@gmail.com>
Message-ID: <20130527071637.GL7782@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 24, 2013 at 04:55:41PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Fix the following sparse warning:
> 
> arch/arm/mach-imx/irq-common.c:24:5: warning: symbol 'mxc_set_irq_fiq' was not declared. Should it be static?
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Both applied, thanks.
