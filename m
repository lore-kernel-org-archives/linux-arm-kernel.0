From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 6 Jan 2017 16:01:57 +0200
Subject: [PATCH v5 1/5] arm64: dts: exynos5433: TM2/E: Fix wrong values
 for ldo23 and ldo25
In-Reply-To: <20170106134350.32428-2-andi.shyti@samsung.com>
References: <20170106134350.32428-1-andi.shyti@samsung.com>
 <CGME20170106134355epcas1p1c201edf5dabed68506eb6bf9f9e0a1ee@epcas1p1.samsung.com>
 <20170106134350.32428-2-andi.shyti@samsung.com>
Message-ID: <20170106140157.6xn34r5kkuattzsh@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 06, 2017 at 10:43:46PM +0900, Andi Shyti wrote:
> From: Chanwoo Choi <cw00.choi@samsung.com>
> 
> This patch fixes wrong values assigned to ldo23 and ldo25 on both TM2 and TM2E.
> 
> Fixes: 01e5d2352152 ("arm64: dts: exynos: Add dts file for Exynos5433-based TM2 board")
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433-tm2.dts  | 6 +++---
>  arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts | 9 ---------
>  2 files changed, 3 insertions(+), 12 deletions(-)
> 

Thanks, applied.

Best regards,
Krzysztof
