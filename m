From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 1 Aug 2017 10:16:45 +0200
Subject: [PATCH 5/6] pinctrl: uniphier: add suspend / resume support
In-Reply-To: <1501482071-9819-6-git-send-email-yamada.masahiro@socionext.com>
References: <1501482071-9819-1-git-send-email-yamada.masahiro@socionext.com>
 <1501482071-9819-6-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdZnyT7Anf4+U79hbHRFEvsEJNh8yF+9pW=bq65BDibHMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 31, 2017 at 8:21 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> Save registers lost in the sleep when suspending, and restore them
> when resuming.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Patch applied.

Yours,
Linus Walleij
