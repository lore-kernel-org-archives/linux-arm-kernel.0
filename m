From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 27 Jul 2015 22:36:53 +0800
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Select CONFIG_IKCONFIG_PROC
In-Reply-To: <1436881786-9886-1-git-send-email-fabio.estevam@freescale.com>
References: <1436881786-9886-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20150727143653.GR12927@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 14, 2015 at 10:49:46AM -0300, Fabio Estevam wrote:
> It is useful to know how the kernel was configured via:
> zcat /proc/config.gz ,so select the CONFIG_IKCONFIG_PROC option.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.
