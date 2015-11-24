From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 24 Nov 2015 13:46:02 +0800
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Remove CONFIG_SOC_LS1021A
In-Reply-To: <1446129295-11775-1-git-send-email-fabio.estevam@freescale.com>
References: <1446129295-11775-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20151124054602.GF11999@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 29, 2015 at 12:34:55PM -0200, Fabio Estevam wrote:
> imx_v6_v7_defconfig is not suitable for booting LS1021 as it needs
> LPAE.
> 
> Remove this option.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.
