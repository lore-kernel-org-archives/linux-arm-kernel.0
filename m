From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 16 May 2014 10:59:06 +0200
Subject: [PATCH 4/7] ARM: EXYNOS: PM: replace EXYNOS_BOOT_VECTOR_* macros
 by static inlines
In-Reply-To: <1399287439-31376-5-git-send-email-b.zolnierkie@samsung.com>
References: <1399287439-31376-1-git-send-email-b.zolnierkie@samsung.com>
 <1399287439-31376-5-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <5375D35A.6030806@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/05/2014 12:57 PM, Bartlomiej Zolnierkiewicz wrote:
> Replace EXYNOS_BOOT_VECTOR_ADDR and EXYNOS_BOOT_VECTOR_FLAG macros
> by exynos_boot_vector_addr() and exynos_boot_vector_flag() static
> inlines.
>
> This patch shouldn't cause any functionality changes.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
