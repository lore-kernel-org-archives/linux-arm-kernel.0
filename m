From: scottwood@freescale.com (Scott Wood)
Date: Fri, 29 Aug 2014 14:38:15 -0500
Subject: [PATCHv2] clk: ppc-corenet: rename to ppc-qoriq and add
 CLK_OF_DECLARE support
In-Reply-To: <1409301354-13699-1-git-send-email-jingchang.lu@freescale.com>
References: <1409301354-13699-1-git-send-email-jingchang.lu@freescale.com>
Message-ID: <1409341095.24184.18.camel@snotra.buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-08-29 at 16:35 +0800, Jingchang Lu wrote:
> The IP is shared on PPC and ARM, this rename it to qoriq for better
> represention, and this also add the CLK_OF_DECLARE support for being
> initialized by of_clk_init() on ARM.
> 
> Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
> ---
> changes in v2:
>  rename the driver name to ppc-qoriq.c for shared on PPC and ARM.
> 
>  drivers/clk/Kconfig           |   9 +-
>  drivers/clk/Makefile          |   2 +-
>  drivers/clk/clk-ppc-corenet.c | 307 -----------------------------------------
>  drivers/clk/clk-qoriq.c       | 312 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 318 insertions(+), 312 deletions(-)
>  delete mode 100644 drivers/clk/clk-ppc-corenet.c
>  create mode 100644 drivers/clk/clk-qoriq.c

Please use -M -C with git format-patch to detect the rename, so we can
see what changed during the rename.

-Scott
