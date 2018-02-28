From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 28 Feb 2018 09:49:21 +0800
Subject: [PATCH] ARM: dts: imx6: Pass memory unit-adress
In-Reply-To: <1519319795-18161-1-git-send-email-festevam@gmail.com>
References: <1519319795-18161-1-git-send-email-festevam@gmail.com>
Message-ID: <20180228014920.GB3217@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 22, 2018 at 02:16:35PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Pass the memory unit-adress to fix the following build warnings with W=1:
> 
> Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name
> 
> There are cases where dts passes an empty memory node, which will be filled
> by the bootloader. Passing the memory base address still allows the 
> bootloader to fill the memory size.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
