From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 20 Jun 2014 21:29:51 +0800
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Enable CONFIG_IMX_IPUV3_CORE
In-Reply-To: <1403233344-28333-1-git-send-email-festevam@gmail.com>
References: <1403233344-28333-1-git-send-email-festevam@gmail.com>
Message-ID: <20140620132950.GM28225@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 20, 2014 at 12:02:24AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Since commit 39b9004d1f (gpu: ipu-v3: Move i.MX IPUv3 core driver out of 
> staging) the ipuv3 core driver is no longer built bey default.
> 
> Select CONFIG_IMX_IPUV3_CORE so that the core ipuv3 code can be built again.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.
