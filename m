From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 27 Apr 2015 22:49:34 +0800
Subject: [PATCH 2/2] ARM: imx: mmdc: Include "common.h" header file
In-Reply-To: <1428013412-7082-2-git-send-email-festevam@gmail.com>
References: <1428013412-7082-1-git-send-email-festevam@gmail.com>
 <1428013412-7082-2-git-send-email-festevam@gmail.com>
Message-ID: <20150427144921.GE1788@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 02, 2015 at 07:23:32PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Include the "common.h" header file to fix the following sparse warning:
> 
> arch/arm/mach-imx/mmdc.c:66:5: warning: symbol 'imx_mmdc_get_ddr_type' was not declared. Should it be static?
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.
