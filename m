From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 25 Feb 2013 11:41:15 +0800
Subject: [PATCH] ARM: mxs_defconfig: Select CONFIG_MMC_UNSAFE_RESUME
In-Reply-To: <1361556622-2550-1-git-send-email-fabio.estevam@freescale.com>
References: <1361556622-2550-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20130225034112.GA2687@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 22, 2013 at 03:10:22PM -0300, Fabio Estevam wrote:
> PM subsystem treats mmc card as removed during suspend.
> 
> If MMC is used to store the root file system, it is better to tell the kernel
> not to treat it as a removable media, so select CONFIG_MMC_UNSAFE_RESUME for
> such purpose.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Queued for 3.10, thanks.
