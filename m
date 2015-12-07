From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 07 Dec 2015 16:25:37 +0100
Subject: [PATCH v3 06/10] clk: samsung: exynos5800: fix cpu clock
 configuration data
In-Reply-To: <1449250235-9613-7-git-send-email-b.zolnierkie@samsung.com>
References: <1449250235-9613-1-git-send-email-b.zolnierkie@samsung.com>
 <1449250235-9613-7-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <5665A4F1.8000504@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/12/15 18:30, Bartlomiej Zolnierkiewicz wrote:
> Fix cpu clock configuration data for Exynos5800 (it uses
> higher PCLK_DBG divider values than Exynos5420 and supports
> additional frequencies).
> 
> Based on Hardkernel's kernel for ODROID-XU3 board.
> 
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

-- 
Regards,
Sylwester
