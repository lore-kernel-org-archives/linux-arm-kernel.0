From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 29 Nov 2017 15:00:04 +0800
Subject: [PATCH] ARM: dts: imx53-cx9020: Fix the Ethernet PHY reset GPIO
 polarity
In-Reply-To: <1511650267-21933-1-git-send-email-festevam@gmail.com>
References: <1511650267-21933-1-git-send-email-festevam@gmail.com>
Message-ID: <20171129070002.GL9376@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 25, 2017 at 08:51:07PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> As explained in Documentation/devicetree/bindings/net/fsl-fec.txt the
> phy-reset-gpios is active high only if the 'phy-reset-active-high' is
> present.
> 
> As 'phy-reset-active-high' is not used here, fix the device tree
> description by passing GPIO_ACTIVE_LOW flag.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
