From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 9 Mar 2015 11:08:49 +0100
Subject: [PATCH] pinctrl: exynos: Remove eint_gpio_init call-back for
 exynos7 alive pinctrl block
In-Reply-To: <1425226876-5122-1-git-send-email-a.kesavan@samsung.com>
References: <1425226876-5122-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <CACRpkdY+Cuqi9_ysUc50aoUny8TAtLc91yfFKdA3VRt-5VyAjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 1, 2015 at 5:21 PM, Abhilash Kesavan <a.kesavan@samsung.com> wrote:

> The alive pin controller on exynos7 does not support external gpio
> interrupts. Hence, remove the eint_gpio_init call-back for it. This
> fixes the following error message seen during exynos7 boot-up:
> "samsung-pinctrl 10580000.pinctrl: irq number not available"
>
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>

Tomasz, can you look at this patch?

Yours,
Linus Walleij
