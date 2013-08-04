From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 4 Aug 2013 17:04:08 +0800
Subject: [PATCH 1/2] ARM: mxs_defconfig: Cleanup mxs_defconfig
In-Reply-To: <1375186555-4661-1-git-send-email-festevam@gmail.com>
References: <1375186555-4661-1-git-send-email-festevam@gmail.com>
Message-ID: <20130804090406.GA18119@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 09:15:54AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Generate mxs_defconfig by doing:
> 
> make mxs_defconfig
> make savedefconfig
> cp defconfig arch/arm/configs/mxs_defconfig
> 
> No functional change. The goal here is to cleanup mxs_defconfig file to
> make easier and cleaner the addition of new entries.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Both applied, thanks.
