From: s.nawrocki@samsung.com (Sylwester nawrocki)
Date: Wed, 15 Jul 2015 19:01:37 +0900
Subject: [PATCH v3 1/4] clk: samsung: exynos5250: add cpu clock
 configuration data and instantiate cpu clock
In-Reply-To: <1435756238-845-2-git-send-email-b.zolnierkie@samsung.com>
References: <1435756238-845-1-git-send-email-b.zolnierkie@samsung.com>
 <1435756238-845-2-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <55A62F81.3080801@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/01/2015 10:10 PM, Bartlomiej Zolnierkiewicz wrote:
> From: Thomas Abraham<thomas.ab@samsung.com>
>
> With the addition of the new Samsung specific cpu-clock type, the
> arm clock can be represented as a cpu-clock type. Add the CPU clock
> configuration data and instantiate the CPU clock type for Exynos5250.
>
> Changes by Bartlomiej:
> - split Exynos5250 support from the original patch
> - moved E5250_CPU_DIV[0,1]() macros to clk-exynos5250.c
>
> Cc: Tomasz Figa<tomasz.figa@gmail.com>
> Cc: Michael Turquette<mturquette@baylibre.com>
> Cc: Javier Martinez Canillas<javier@dowhile0.org>
> Signed-off-by: Thomas Abraham<thomas.ab@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz<b.zolnierkie@samsung.com>

Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
