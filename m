From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 26 Jan 2013 15:10:31 -0500
Subject: [PATCH 3/3] ARM: Kirkwood: Convert QNAP TS219 Ethernet to DT.
In-Reply-To: <1359213030-18588-4-git-send-email-andrew@lunn.ch>
References: <1359213030-18588-1-git-send-email-andrew@lunn.ch>
 <1359213030-18588-4-git-send-email-andrew@lunn.ch>
Message-ID: <20130126201031.GQ1758@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 26, 2013 at 04:10:30PM +0100, Andrew Lunn wrote:
> Add DT nodes for the Ethernet ports and remove the C code. The PHY
> addresses depends on which SoC is used, so place the nodes into the
> SoC specific DTS files.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/boot/dts/kirkwood-ts219-6281.dts |    9 +++++++
>  arch/arm/boot/dts/kirkwood-ts219-6282.dts |   10 ++++++++
>  arch/arm/mach-kirkwood/Kconfig            |   17 ++-----------
>  arch/arm/mach-kirkwood/Makefile           |    1 -
>  arch/arm/mach-kirkwood/board-dt.c         |    3 ---
>  arch/arm/mach-kirkwood/board-ts219.c      |   37 -----------------------------
>  arch/arm/mach-kirkwood/common.h           |    6 -----
>  7 files changed, 21 insertions(+), 62 deletions(-)
>  delete mode 100644 arch/arm/mach-kirkwood/board-ts219.c

Pulled into the series.  Thanks.

fyi - I also converted keymile.  The only one left is the iomega_ix2_200
board.  Which only inits ge01.

thx,

Jason.
