From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 18 Feb 2016 11:51:13 +0530
Subject: [PATCH v2 1/3] ARM: dts: Add cooling levels for CPUs on exynos5420
In-Reply-To: <1455772383-20598-1-git-send-email-k.kozlowski@samsung.com>
References: <1455772383-20598-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20160218062113.GS2610@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18-02-16, 14:13, Krzysztof Kozlowski wrote:
> On Exynos5420 we support 8 cpufreq steps (600-1300 MHz) for LITTLE and
> 12 steps for big core (700-1800 MHz). Add respective cooling cells.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> ---
> 
> Changes since v1:
> 1. Add cooling properties to all CPUs (suggested by Viresh).
> ---
>  arch/arm/boot/dts/exynos5420-cpus.dtsi | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
