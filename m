From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 10 Feb 2014 10:44:09 +0800
Subject: [PATCH 1/2] ARM: imx_v4_v5_defconfig: Select
 CONFIG_MMC_UNSAFE_RESUME
In-Reply-To: <1391094252-10599-1-git-send-email-fabio.estevam@freescale.com>
References: <1391094252-10599-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20140210024406.GA9628@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 30, 2014 at 01:04:11PM -0200, Fabio Estevam wrote:
> PM subsystem treats mmc card as removed during suspend.
>     
> If MMC is used to store the root file system, it is better to tell the kernel
> not to treat it as a removable media, so select CONFIG_MMC_UNSAFE_RESUME for
> such purpose.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied both, thanks.
