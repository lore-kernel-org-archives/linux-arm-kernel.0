From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 13 Feb 2018 19:16:36 +0100
Subject: [PATCH 01/10] ARM: dts: exynos: Remove "cooling-{min|max}-level"
 for CPU nodes
In-Reply-To: <f808613a9c7a4f23d3a0c64b6f3d4df1b905b16b.1518166039.git.viresh.kumar@linaro.org>
References: <cover.1518166039.git.viresh.kumar@linaro.org>
 <f808613a9c7a4f23d3a0c64b6f3d4df1b905b16b.1518166039.git.viresh.kumar@linaro.org>
Message-ID: <20180213181636.dwjyfqcunynonwrf@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 09, 2018 at 02:28:01PM +0530, Viresh Kumar wrote:
> The "cooling-min-level" and "cooling-max-level" properties are not
> parsed by any part of the kernel currently and the max cooling state of
> a CPU cooling device is found by referring to the cpufreq table instead.
> 
> Remove the unused properties from the CPU nodes.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm/boot/dts/exynos4210.dtsi      |  2 --
>  arch/arm/boot/dts/exynos4412.dtsi      |  2 --
>  arch/arm/boot/dts/exynos5250.dtsi      |  2 --
>  arch/arm/boot/dts/exynos5420-cpus.dtsi | 16 ----------------
>  arch/arm/boot/dts/exynos5422-cpus.dtsi | 16 ----------------
>  5 files changed, 38 deletions(-)
> 

Thanks, applied.

Best regards,
Krzysztof
