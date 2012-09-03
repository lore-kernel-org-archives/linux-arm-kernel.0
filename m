From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 3 Sep 2012 13:17:00 +0200
Subject: [PATCH v3 4/4] ARM: EXYNOS: skip wakeup interrupt setup if
 pinctrl driver is used
In-Reply-To: <1345720529-32315-5-git-send-email-thomas.abraham@linaro.org>
References: <1345720529-32315-1-git-send-email-thomas.abraham@linaro.org>
 <1345720529-32315-5-git-send-email-thomas.abraham@linaro.org>
Message-ID: <CACRpkda5MkXbePf8B8rY8w3rjowzE8MqtWH_cehOqUoKTTY=9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 23, 2012 at 1:15 PM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:

> Pinctrl driver includes support for configuring the external wakeup
> interrupts. On exynos platforms that use pinctrl driver, the setup
> of wakeup interrupts in the exynos platform code can be skipped.
>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
