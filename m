From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 16 Dec 2014 15:38:55 +0800
Subject: [PATCH] ARM: dts: imx25: Fix the SPI1 clocks
In-Reply-To: <1417803367-23448-1-git-send-email-festevam@gmail.com>
References: <1417803367-23448-1-git-send-email-festevam@gmail.com>
Message-ID: <20141216073853.GE2411@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 05, 2014 at 04:16:07PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> From Documentation/devicetree/bindings/clock/imx25-clock.txt:
> 
> 	cspi1_ipg		78
> 	cspi2_ipg		79
> 	cspi3_ipg		80
> 
> , so fix the SPI1 clocks accordingly to avoid a kernel hang when trying to
> access SPI1.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.
