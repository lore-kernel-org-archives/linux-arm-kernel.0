From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 31 May 2016 12:45:44 +0200
Subject: [PATCH 07/17] pinctrl: uniphier: rename macros for drive strength
 control
In-Reply-To: <1464681923-7469-8-git-send-email-yamada.masahiro@socionext.com>
References: <1464681923-7469-1-git-send-email-yamada.masahiro@socionext.com>
 <1464681923-7469-8-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdZGNU_fu+66tEheuE_bY0nW+M18BsQNQAsL2Qs7=g4S_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 31, 2016 at 10:05 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> The new ARMv8 SoC, PH1-LD20, supports more fine-grained drive
> strength control.  Some of the configuration registers on it have
> 3-bit width.
>
> The feature will be supported in the next commit, but a problem is
> that macro names are getting longer and longer in the current naming
> scheme.
>
> Before moving forward, this commit renames macros as follows:
>
>   UNIPHIER_PIN_DRV_4_8        -> UNIPHIER_PIN_DRV_1BIT
>   UNIPHIER_PIN_DRV_8_12_16_20 -> UNIPHIER_PIN_DRV_2BIT
>   UNIPHIER_PIN_DRV_FIXED_4    -> UNIPHIER_PIN_DRV_FIXED4
>   UNIPHIER_PIN_DRV_FIXED_5    -> UNIPHIER_PIN_DRV_FIXED5
>   UNIPHIER_PIN_DRV_FIXED_8    -> UNIPHIER_PIN_DRV_FIXED8
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Patch applied.

Yours,
Linus Walleij
