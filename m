From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 28 Aug 2013 08:50:30 +0200
Subject: [PATCH 04/18] dmaengine: PL08x: Move LLI dumping code into
 separate function
In-Reply-To: <1376243970-6489-5-git-send-email-tomasz.figa@gmail.com>
References: <1376243970-6489-1-git-send-email-tomasz.figa@gmail.com>
 <1376243970-6489-5-git-send-email-tomasz.figa@gmail.com>
Message-ID: <CACRpkdY_fjdoR06=uhLpuF+LZ8rQ7h_+i2XQdsbAm-uy4wh0MQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 11, 2013 at 7:59 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:

> This patch refactors debugging code that dumps LLI entries by moving it
> into separate function, which is stubbed when VERBOSE_DEBUG is not
> selected. This allows us to get rid of the ugly ifdef from the body of
> pl08x_fill_llis_for_desc().
>
> No functional change is introduced by this patch.
>
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
