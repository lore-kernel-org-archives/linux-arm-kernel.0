From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 12 Jul 2017 16:51:27 +0800
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Select the coda driver as module
In-Reply-To: <1499440005-8067-1-git-send-email-festevam@gmail.com>
References: <1499440005-8067-1-git-send-email-festevam@gmail.com>
Message-ID: <20170712085126.GM3172@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 07, 2017 at 12:06:45PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> The coda driver may be probed prior to the rootfs being available, leading
> to firmware loading failure.
> 
> To avoid such problem, select the coda driver as module.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
