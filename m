From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 31 May 2018 10:51:09 +0530
Subject: [PATCH] ARM: dts: exynos: Add missing CPU clocks to secondary
 CPUs on Exynos542x
In-Reply-To: <20180530164922.31851-1-krzk@kernel.org>
References: <20180530164922.31851-1-krzk@kernel.org>
Message-ID: <20180531052109.f43trnba7ux6tno2@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30-05-18, 18:49, Krzysztof Kozlowski wrote:
> Secondary CPUs should have the same information in DeviceTree as booting
> CPU from both correctness point of view and for possible hotplug
> scenarios.
> 
> Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/exynos5420-cpus.dtsi | 6 ++++++
>  arch/arm/boot/dts/exynos5422-cpus.dtsi | 8 +++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)

Nice.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
