From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Wed, 2 Jan 2013 17:29:34 +0530
Subject: [PATCH] ARM: EXYNOS: fix uncompress.h and debug-macro.S for
 EXYNOS5440
In-Reply-To: <1356632834-8934-1-git-send-email-kgene.kim@samsung.com>
References: <1356632834-8934-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <CAK9yfHycpk6S1e3wW-8hLB7HM2tFykZGOSiz2jaYVwMf2khOUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

On 27 December 2012 23:57, Kukjin Kim <kgene.kim@samsung.com> wrote:
> This patch fixes uart base address for uncompress and debug-macro
> on EXYNOS5440.
>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/mach-exynos/include/mach/debug-macro.S |   25 +++++++++++++++++------
>  arch/arm/mach-exynos/include/mach/map.h         |    1 +
>  arch/arm/mach-exynos/include/mach/uncompress.h  |   20 +++++++++++-------
>  3 files changed, 33 insertions(+), 13 deletions(-)

With this patch I found that Origen board does not boot.
It stops at "Uncompressing Linux...".
Tested using your latest for-next branch.

---
With warm regards,
Sachin
