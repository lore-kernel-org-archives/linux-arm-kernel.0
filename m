From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 5 Nov 2012 12:37:32 +0100
Subject: [PATCH 6/7] pinctrl: exynos5440: add pinctrl driver for Samsung
 EXYNOS5440 SoC
In-Reply-To: <1351274153-3120-6-git-send-email-kgene.kim@samsung.com>
References: <1351274153-3120-1-git-send-email-kgene.kim@samsung.com>
 <1351274153-3120-6-git-send-email-kgene.kim@samsung.com>
Message-ID: <CACRpkdZP_sTKV1Nq3FWVQJocg8C8H7J9vd9hmY4k-qAnMPJcLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 26, 2012 at 7:55 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:

> From: Thomas Abraham <thomas.abraham@linaro.org>
>
> Add a new pinctrl driver for Samsung EXYNOS5440 SoC. The pin controller
> module in EXYNOS5440 is different from the pin controller found on other
> Samsung SoC. Hence, the pin controller driver for EXYNOS5440 SoC is
> independent of the Samsung pinctrl framework.
>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>

If I haven't ACK:ed this before here's an
Acked-by: Linus Walleij <linus.walleij@linaro.org>

I expect this to go through the Samsung tree?

Yours,
Linus Walleij
