From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 11 Nov 2014 22:22:22 +0800
Subject: [PATCH] ARM: dts: imx6q-tbs2910: Remove unneeded 'fsl,mode'
 property
In-Reply-To: <1415189571-24035-1-git-send-email-festevam@gmail.com>
References: <1415189571-24035-1-git-send-email-festevam@gmail.com>
Message-ID: <20141111142221.GE2704@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 05, 2014 at 10:12:51AM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> imx6q-tbs2910 board uses sgtl5000 codec and the machine file (imx-sgtl5000)
> already sets SSI in slave mode and codec in master mode, so there is no need
> for having this property.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.
