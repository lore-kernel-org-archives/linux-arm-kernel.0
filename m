From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 7 Sep 2016 23:18:39 +0200
Subject: [PATCH v3 01/17] pinctrl: dt-bindings: samsung: Add header with
 values used for configuration
In-Reply-To: <1472987060-28293-2-git-send-email-krzk@kernel.org>
References: <1472987060-28293-1-git-send-email-krzk@kernel.org>
 <1472987060-28293-2-git-send-email-krzk@kernel.org>
Message-ID: <CACRpkdb9gq0Zez=_NW8XB6YKiJteC3GB12e-Wi9my52b4Q-C7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 4, 2016 at 1:04 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:

> From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>
> Hard-coded pinctrl configuration values are scattered through DTS files.
> The numbers are difficult to decode by human, especially without the
> datasheet.  Additionally the drive strength differs between S3C64xx,
> S5PV210 and Exynos SoC families increasing the confusion.
>
> The header will help making this more readable and maintainable.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Take this with the rest of the changes into ARM SoC.

Yours,
Linus Walleij
