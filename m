From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 3 Jun 2011 18:14:26 +0200
Subject: [PATCH v3 1/4] mmc: support sdhci-pxav3.c
In-Reply-To: <1307094572-8378-1-git-send-email-zhangfei.gao@marvell.com>
References: <1307094572-8378-1-git-send-email-zhangfei.gao@marvell.com>
Message-ID: <201106031814.26414.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 03 June 2011, Zhangfei Gao wrote:
>         Instead of sharing sdhci-pxa.c, use sdhci-pxav3.c for mmp2.
>         The original method is not easy to track, which is share sdhci-pxa.c among pxa serious, like pxa910, mmp2, etc,
>         and put the platfrom difference under arch/arm.
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
> Signed-off-by: Philip Rakity <prakity@marvell.com>

Looks very good now,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
