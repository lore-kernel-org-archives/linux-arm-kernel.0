From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 16 Jul 2015 15:15:41 +0200
Subject: [PATCH] pinctrl: Drop owner assignment from platform_driver
In-Reply-To: <1436509650-5218-1-git-send-email-k.kozlowski@samsung.com>
References: <1436509650-5218-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <CACRpkdbkM+PBA5CB5yiCbaFvQkJD+mqYnTz3MEHoAd6rkWqikA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 10, 2015 at 8:27 AM, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:

> platform_driver does not need to set an owner because
> platform_driver_register() will set it.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Patch applied.

Yours,
Linus Walleij
