From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 18 Mar 2015 14:39:32 +0100
Subject: [PATCH v3 4/4] ARM: EXYNOS: cpuidle: allow driver usage on
 Exynos3250 SoC
In-Reply-To: <1426683113-31209-5-git-send-email-b.zolnierkie@samsung.com>
References: <1426683113-31209-1-git-send-email-b.zolnierkie@samsung.com>
 <1426683113-31209-5-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <CAJKOXPfg1UZ9N_FVoHgrE-aZq3y5JUcuE0H1deaZexMXTYZVmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-03-18 13:51 GMT+01:00 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>:
> Register cpuidle platform device on Exynos3250 SoC allowing EXYNOS
> cpuidle driver usage on this SoC.
>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-exynos/exynos.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
