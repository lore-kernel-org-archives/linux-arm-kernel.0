From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 30 Jul 2013 14:48:20 +0800
Subject: [PATCH 1/2] ARM: imx_v6_v7_defconfig: Cleanup imx_v6_v7_defconfig
In-Reply-To: <1375067056-6370-1-git-send-email-festevam@gmail.com>
References: <1375067056-6370-1-git-send-email-festevam@gmail.com>
Message-ID: <20130730064818.GC12382@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 29, 2013 at 12:04:15AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Generate imx_v6_v7_defconfig by doing:
> 
> make savedefconfig
> 
> cp defconfig arch/arm/configs/imx_v6_v7_defconfig
> 
> No functional change. The goal here is to cleanup imx_v6_v7_defconfig file to
> make easier and cleaner the addition of new entries.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied both, thanks.
