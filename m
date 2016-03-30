From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 30 Mar 2016 17:30:34 +0900
Subject: [PATCH V3 3/4] ARM: exynos: exynos-cpufreq platform device isn't
 supported anymore
In-Reply-To: <abff8b995fce34ea80c68c5d11ccb8a525fb81fa.1459325515.git.viresh.kumar@linaro.org>
References: <cover.1459325515.git.viresh.kumar@linaro.org>
 <abff8b995fce34ea80c68c5d11ccb8a525fb81fa.1459325515.git.viresh.kumar@linaro.org>
Message-ID: <56FB8EAA.3010203@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.03.2016 17:15, Viresh Kumar wrote:
> The driver is removed long back and we don't support this device
> anymore. Stop adding it.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm/mach-exynos/exynos.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>



Best regards,

Krzysztof
