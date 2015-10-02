From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 2 Oct 2015 04:05:34 -0700
Subject: [PATCH v3 0/2] pinctrl: uniphier: one fix, one addition
In-Reply-To: <1443097607-29011-1-git-send-email-yamada.masahiro@socionext.com>
References: <1443097607-29011-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdYUYXZHyzaPMPZyRMm6CKwL7GJHmEH600wsh_DXgGGhMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 24, 2015 at 5:26 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> 1/2 is a bug fix, but it is not very critical.
> I can wait until 4.4-rc1 if it is a hassle.
>
> 2/2 provides some more pin-mux settings.
>
>
> Changes in v3:
>   - Sort pin groups alphabetically
>   - Add missing UNIPHIER_PINMUX_FUNCTION(sd) to ph1_sld8_functions

OK missed this v3 version was out, sorry.

Pulling out the previos fix and replacing with this.

Yours,
Linus Walleij
