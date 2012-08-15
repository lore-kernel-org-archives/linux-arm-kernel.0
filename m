From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 15 Aug 2012 23:00:46 +0800
Subject: [PATCH v3 2/2] ARM: mach-mxs: Remove board entries in
 dt_board_compat
In-Reply-To: <1345040940-3045-1-git-send-email-festevam@gmail.com>
References: <1345040940-3045-1-git-send-email-festevam@gmail.com>
Message-ID: <20120815150043.GE2258@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 15, 2012 at 11:29:00AM -0300, Fabio Estevam wrote:
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
