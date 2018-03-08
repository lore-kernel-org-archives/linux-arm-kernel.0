From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 8 Mar 2018 16:26:34 +0800
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Select CONFIG_SND_SOC_WM8962
 explicitly
In-Reply-To: <1519931336-9710-1-git-send-email-festevam@gmail.com>
References: <1519931336-9710-1-git-send-email-festevam@gmail.com>
Message-ID: <20180308082633.GS3217@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2018 at 04:08:56PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Currently CONFIG_SND_SOC_WM8962 is selected via SND_SOC_IMX_WM8962
> machine driver option.
> 
> SND_SOC_IMX_WM8962 will be removed in the next kernel cycle, so
> select the codec driver directly so that it can still be used
> by default via the generic fsl-asoc-card machine driver.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
