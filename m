From: s.nawrocki@samsung.com (Sylwester nawrocki)
Date: Wed, 15 Jul 2015 18:58:17 +0900
Subject: [PATCH v2 4/7] clk: samsung: exynos4x12: add cpu clock
 configuration data and instantiate cpu clock
In-Reply-To: <1436456621-29839-5-git-send-email-b.zolnierkie@samsung.com>
References: <1436456621-29839-1-git-send-email-b.zolnierkie@samsung.com>
 <1436456621-29839-5-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <55A62EB9.7040902@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/10/2015 12:43 AM, Bartlomiej Zolnierkiewicz wrote:
> With the addition of the new Samsung specific cpu-clock type, the
> arm clock can be represented as a cpu-clock type. Add the CPU clock
> configuration data and instantiate the CPU clock type for Exynos4x12.
>
> Based on the earlier work by Thomas Abraham.
>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Javier Martinez Canillas <javier@dowhile0.org>
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>   drivers/clk/samsung/clk-exynos4.c | 50 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 50 insertions(+)

I guess you prefer to have this whole series applied through one,
e.g samsung-soc tree? If so, here is my ack.

Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
