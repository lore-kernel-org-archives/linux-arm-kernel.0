From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 08 Sep 2015 09:34:28 +0900
Subject: [PATCH v4 4/4] ARM: dts: add suspend opp to exynos4412
In-Reply-To: <1441640501-13613-5-git-send-email-b.zolnierkie@samsung.com>
References: <1441640501-13613-1-git-send-email-b.zolnierkie@samsung.com>
 <1441640501-13613-5-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <55EE2D14.2080203@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.09.2015 00:41, Bartlomiej Zolnierkiewicz wrote:
> Mark 800MHz OPP as a suspend opp for Exynos4412 based
> boards so effectively cpufreq-dt driver behavior w.r.t.
> suspend frequency matches what the old exynos-cpufreq
> driver has been doing.
> 
> This patch fixes suspend/resume support on Exynos4412 based
> Trats2 board and reboot hang on Exynos4412 based Odroid U3
> board.
> 
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4412.dtsi | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
