From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 6 Jan 2017 08:49:15 +0200
Subject: [PATCH v2 4/4] ARM64: dts: TM2: comply to the samsung pinctrl
 naming convention
In-Reply-To: <20161230041421.24448-5-andi.shyti@samsung.com>
References: <20161230041421.24448-1-andi.shyti@samsung.com>
 <CGME20161230041427epcas1p135fd1703c0bb0cc47a60f4c619b49973@epcas1p1.samsung.com>
 <20161230041421.24448-5-andi.shyti@samsung.com>
Message-ID: <20170106064915.33zblfctcnrh55jg@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 30, 2016 at 01:14:21PM +0900, Andi Shyti wrote:
> Change the PIN() macro definition so that it can use the macros
> from pinctrl/samsung.h header file.
> 
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi |  25 +-
>  arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      | 254 ++++++++++-----------
>  2 files changed, 133 insertions(+), 146 deletions(-)
> 

Thanks, applied (here and in 3/4 with fixed subject).

Best regards,
Krzysztof
