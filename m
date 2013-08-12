From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 12 Aug 2013 13:38:18 -0400
Subject: [PATCH 2/2] Remove all remaining trace of DNS-320/325 platform
 code
In-Reply-To: <1376231210-6484-3-git-send-email-jm@lentin.co.uk>
References: <1376231210-6484-1-git-send-email-jm@lentin.co.uk>
 <1376231210-6484-3-git-send-email-jm@lentin.co.uk>
Message-ID: <20130812173818.GN25111@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 11, 2013 at 03:26:50PM +0100, Jamie Lentin wrote:
> No platform code left now, so remove all references to it.
> 
> Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
> ---
>  arch/arm/configs/kirkwood_defconfig  |  1 -
>  arch/arm/mach-kirkwood/Kconfig       |  8 --------
>  arch/arm/mach-kirkwood/Makefile      |  1 -
>  arch/arm/mach-kirkwood/board-dnskw.c | 21 ---------------------
>  arch/arm/mach-kirkwood/board-dt.c    |  3 ---
>  arch/arm/mach-kirkwood/common.h      |  6 ------
>  6 files changed, 40 deletions(-)
>  delete mode 100644 arch/arm/mach-kirkwood/board-dnskw.c

Applied to mvebu/boards without patch #1.  Added a note to the commit re
the reset gpio never working.

thx,

Jason.
