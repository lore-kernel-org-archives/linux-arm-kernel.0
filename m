From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 12 Jul 2011 19:51:47 +0800
Subject: [PATCH] i.MX53: Initial Ka-Ro electronics TX53 board support
In-Reply-To: <1310469518-23615-1-git-send-email-LW@KARO-electronics.de>
References: <1310469518-23615-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <20110712115146.GC19105@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 12, 2011 at 01:18:38PM +0200, Lothar Wa?mann wrote:
> This patch adds initial board support for the Ka-Ro electronics TX53
> processor module (MACH_TX53).
> 
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> ---
>  arch/arm/mach-mx5/Kconfig                   |   15 +
>  arch/arm/mach-mx5/Makefile                  |    1 +
>  arch/arm/mach-mx5/board-tx53.c              |  400 +++++++++++++++++++++++++++
>  arch/arm/plat-mxc/include/mach/uncompress.h |    1 +
>  4 files changed, 417 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-mx5/board-tx53.c
> 
I'm not sure if it makes sense to add another board support, while
we are migrating to device tree.

-- 
Regards,
Shawn
