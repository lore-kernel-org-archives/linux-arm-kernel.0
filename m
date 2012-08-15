From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 15 Aug 2012 22:49:25 +0800
Subject: [PATCH v2 1/2] ARM: mach-imx: Remove board entries in
 dt_board_compat
In-Reply-To: <1345040791-3000-1-git-send-email-festevam@gmail.com>
References: <1345040791-3000-1-git-send-email-festevam@gmail.com>
Message-ID: <20120815144922.GD2258@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 15, 2012 at 11:26:30AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> There is no need for adding board related entries into dt_board_compat.
> 
> Leave only the SoC entry.
> 
> This way we do not need to patch a C file when adding dt support for a new board.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.

Regards,
Shawn
