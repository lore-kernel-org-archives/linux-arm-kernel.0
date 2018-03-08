From: robh@kernel.org (Rob Herring)
Date: Wed, 7 Mar 2018 20:01:24 -0600
Subject: [PATCH 12/12] thermal: exynos: remove separate thermal_exynos.h
 header file
In-Reply-To: <1520347435-22970-13-git-send-email-b.zolnierkie@samsung.com>
References: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20180306144520epcas2p4950ac2762036882ccd097fd2bf629bbc@epcas2p4.samsung.com>
 <1520347435-22970-13-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <20180308020124.trvajkrsnbog5uqj@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 06, 2018 at 03:43:55PM +0100, Bartlomiej Zolnierkiewicz wrote:
> thermal_exynos.h is used only by exynos_tmu.c so there is no need
> for a separate include file. Also while it remove unused defines.
> 
> There should be no functional changes caused by this patch.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/thermal/samsung/exynos_tmu.c         |  5 +++--
>  include/dt-bindings/thermal/thermal_exynos.h | 28 ----------------------------
>  2 files changed, 3 insertions(+), 30 deletions(-)
>  delete mode 100644 include/dt-bindings/thermal/thermal_exynos.h

Reviewed-by: Rob Herring <robh@kernel.org>
