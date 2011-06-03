From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 3 Jun 2011 18:16:06 +0200
Subject: [PATCH v3 3/4] ARM: mmp2: update mmp2 mmc resource
In-Reply-To: <1307094632-8949-1-git-send-email-zhangfei.gao@marvell.com>
References: <1307094632-8949-1-git-send-email-zhangfei.gao@marvell.com>
Message-ID: <201106031816.06914.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 03 June 2011, Zhangfei Gao wrote:
> 
>         mmp2 mmc driver name update to sdhci-pxav3 according with sdhci-pxav3.c
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
> ---
>  arch/arm/mach-mmp/brownstone.c |   11 ++++++++++-
>  arch/arm/mach-mmp/mmp2.c       |   16 ++++++++--------
>  2 files changed, 18 insertions(+), 9 deletions(-)

Acked-by: Arnd Bergmann <arnd@arndb.de>
