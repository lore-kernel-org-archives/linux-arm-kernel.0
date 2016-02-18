From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 18 Feb 2016 11:51:33 +0530
Subject: [PATCH v2 2/3] ARM: dts: Add cooling levels for CPUs on
 exynos5422/5800
In-Reply-To: <1455772383-20598-2-git-send-email-k.kozlowski@samsung.com>
References: <1455772383-20598-1-git-send-email-k.kozlowski@samsung.com>
 <1455772383-20598-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20160218062133.GT2610@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18-02-16, 14:13, Krzysztof Kozlowski wrote:
> On Exynos5422 and Exynos5800 we support 12 cpufreq steps (200-1300 MHz) for LITTLE
> and 18 steps for big core (200-1700 MHz). Add respective cooling cells.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> ---
> 
> Changes since v1:
> 1. Add cooling properties to all CPUs (suggested by Viresh).
> ---
>  arch/arm/boot/dts/exynos5422-cpus.dtsi | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
