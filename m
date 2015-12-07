From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 07 Dec 2015 16:23:43 +0100
Subject: [PATCH v3 03/10] clk: samsung: exynos5420: add cpu clock
 configuration data and instantiate cpu clock
In-Reply-To: <1449250235-9613-4-git-send-email-b.zolnierkie@samsung.com>
References: <1449250235-9613-1-git-send-email-b.zolnierkie@samsung.com>
 <1449250235-9613-4-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <5665A47F.4000907@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/12/15 18:30, Bartlomiej Zolnierkiewicz wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> With the addition of the new Samsung specific cpu-clock type, the
> arm clock can be represented as a cpu-clock type. Add the CPU clock
> configuration data and instantiate the CPU clock type for Exynos5420.
> 
> Changes by Bartlomiej:
> - split Exynos5420 support from the original patches
> - moved E5420_[EGL,KFC]_DIV0() macros to clk-exynos5420.c
> 
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

-- 
Regards,
Sylwester
