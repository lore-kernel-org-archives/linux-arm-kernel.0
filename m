From: robh@kernel.org (Rob Herring)
Date: Mon, 5 Feb 2018 00:08:27 -0600
Subject: [PATCH v2 1/4] soc: samsung: pmu: Populate children syscon nodes
In-Reply-To: <20180130211819.17139-2-krzk@kernel.org>
References: <20180130211819.17139-1-krzk@kernel.org>
 <20180130211819.17139-2-krzk@kernel.org>
Message-ID: <20180205060827.vhftmdpucrkv2n5f@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 30, 2018 at 10:18:16PM +0100, Krzysztof Kozlowski wrote:
> The syscon poweroff and restart nodes logically belong to the Power
> Management Unit so populate possible children.
> 
> This also requires providing compatibles for Exynos5410 and Exynos7 so
> the PMU device and its children will be instantiated for them as well.
> Just like Exynos5433, these chipsets are not yet supported by the PMU
> driver.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/samsung/pmu.txt | 6 ++++++
>  drivers/soc/samsung/exynos-pmu.c                      | 7 +++++++
>  2 files changed, 13 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
