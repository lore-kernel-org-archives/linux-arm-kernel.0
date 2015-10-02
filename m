From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 2 Oct 2015 02:53:42 -0700
Subject: [PATCH v2 1/2] pinctrl: uniphier: fix input enable settings for
 PH1-sLD8
In-Reply-To: <1441964010-6885-2-git-send-email-yamada.masahiro@socionext.com>
References: <1441964010-6885-1-git-send-email-yamada.masahiro@socionext.com>
 <1441964010-6885-2-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdZdDtQzSQ9KvqAWA0a6sz13DBp0Nuk-ZfLtZi2hRuG29g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 11, 2015 at 2:33 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> Currently, input enable settings are missing from the PH1-sLD8
> pinctrl driver.  (All the entries in the pin table are set to
> UNIPHIER_PIN_IECTRL_NONE).
>
> Fill the table with correct values.
>
> Fixes: 95372f9dc892 ("pinctrl: UniPhier: add UniPhier PH1-sLD8 pinctrl driver")
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Patch applied for fixes.

Yours,
Linus Walleij
