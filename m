From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 18 May 2015 09:29:52 +0800
Subject: [PATCH] ARM: imx: gpc: Remove .owner field
In-Reply-To: <1431172283-30853-1-git-send-email-festevam@gmail.com>
References: <1431172283-30853-1-git-send-email-festevam@gmail.com>
Message-ID: <20150518012952.GB1071@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 09, 2015 at 08:51:23AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> This platform_driver does not need to set an owner as it will be 
> populated by the driver core.
> 
> The semantic patch that makes this change is available
> in scripts/coccinelle/api/platform_no_drv_owner.cocci.
> 
> More information about semantic patching is available at
> http://coccinelle.lip6.fr/
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.
