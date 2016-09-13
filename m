From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 13 Sep 2016 13:39:47 +0200
Subject: [PATCH] dmaengine: cleanup with list_first_entry_or_null()
In-Reply-To: <1473703697-903-1-git-send-email-yamada.masahiro@socionext.com>
References: <1473703697-903-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdZVhdU2shx5MpcbWwL3xvuPsNt25-bbrAmUXG7p29miNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 12, 2016 at 8:08 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> The combo of list_empty() check and return list_first_entry()
> can be replaced with list_first_entry_or_null().
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Excellent deep semantics patch!

Yours,
Linus Walleij
