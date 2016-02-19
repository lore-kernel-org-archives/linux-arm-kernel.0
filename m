From: andi.shyti@samsung.com (Andi Shyti)
Date: Fri, 19 Feb 2016 13:29:54 +0900
Subject: [PATCH 0/3] thermal: exynos: Fixes for vtmu-supply regulator
 handling
In-Reply-To: <1455819551-4666-1-git-send-email-javier@osg.samsung.com>
References: <1455819551-4666-1-git-send-email-javier@osg.samsung.com>
Message-ID: <20160219042954.GD27936@samsunx.samsung>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

> Javier Martinez Canillas (3):
>   thermal: exynos: List vtmu-supply as optional property in DT binding
>   thermal: exynos: Use devm_regulator_get_optional() for vtmu
>   thermal: exynos: Defer probe if vtmu is present but not registered
> 
>  Documentation/devicetree/bindings/thermal/exynos-thermal.txt | 9 ++++++---
>  drivers/thermal/samsung/exynos_tmu.c                         | 4 +++-
>  2 files changed, 9 insertions(+), 4 deletions(-)

for all of them:

Reviewed-by: Andi Shyti <andi.shyti@samsung.com>

Andi
