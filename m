From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 16 Oct 2017 10:24:15 +0200
Subject: [PATCH v8 0/2] gpio: uniphier: UniPhier GPIO driver
In-Reply-To: <1507808176-5223-1-git-send-email-yamada.masahiro@socionext.com>
References: <1507808176-5223-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdbRtpsmkp5BZcCH4vOvqoeMT_1UGUkOEoJ+mYypgnKezA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 12, 2017 at 1:36 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> Changes in v8:
>   - Move dt-binding header to binding commit
>   - Add MAINTAINERS entry for the binding doc
>   - Add a consumer example to the binding doc

This v8 looks OK to me.

The stuff is still hard to understand, but that is because the HW is
very complex and strangely designed, not because of the driver
author. I really think you did your best, thanks!

I'll wait some days and see if the DT people have something to say
before applying it, but I'm as happy as I can be I guess.

Yours,
Linus Walleij
