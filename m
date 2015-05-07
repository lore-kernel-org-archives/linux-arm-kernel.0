From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 7 May 2015 21:00:58 +0800
Subject: [PATCH v2] clk: imx: clk-cpu: Include "clk.h" header file
In-Reply-To: <1430343282-13739-1-git-send-email-festevam@gmail.com>
References: <1430343282-13739-1-git-send-email-festevam@gmail.com>
Message-ID: <20150507130056.GI3162@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 29, 2015 at 06:34:42PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Include the "clk.h" header file to fix the following sparse warning:
> 
> drivers/clk/imx/clk-cpu.c:77:12: warning: symbol 'imx_clk_cpu' was not declared. Should it be static?
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.
