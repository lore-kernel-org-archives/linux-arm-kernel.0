From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 1 Aug 2017 10:11:24 +0200
Subject: [PATCH 2/6] pinctrl: uniphier: fix pin_config_get() for
 input-enable
In-Reply-To: <1501482071-9819-3-git-send-email-yamada.masahiro@socionext.com>
References: <1501482071-9819-1-git-send-email-yamada.masahiro@socionext.com>
 <1501482071-9819-3-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkda459U9AbS3bXV=H2X8A8EodbEFS5GkgwZKMsBtv8uRPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 31, 2017 at 8:21 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> For LD11/LD20 SoCs (capable of per-pin input enable), iectrl bits are
> located across multiple registers.  So, the register offset must be
> taken into account.  Otherwise, wrong input-enable status is displayed.
>
> While we here, rename the macro because it is a base address.
>
> Fixes: aa543888ca8c ("pinctrl: uniphier: support per-pin input enable for new SoCs")
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Patch applied.

Yours,
Linus Walleij
