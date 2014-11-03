From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 3 Nov 2014 11:41:03 +0800
Subject: [PATCH RESEND 1/2] ARM: dts: imx6qdl-gw5x: Remove unneeded
 'fsl,mode' property
In-Reply-To: <1414439088-5092-1-git-send-email-festevam@gmail.com>
References: <1414439088-5092-1-git-send-email-festevam@gmail.com>
Message-ID: <20141103034101.GC10821@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 27, 2014 at 05:44:47PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> imx6qdl-gw5x boards use sgtl5000 codec and the machine file (imx-sgtl5000)
> already sets SSI in slave mode and codec in master mode, so there is no need
> for having this property.
> 
> Cc: Tim Harvey <tharvey@gateworks.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied both, thanks.
