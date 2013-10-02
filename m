From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 2 Oct 2013 12:46:51 +0200
Subject: [PATCH 2/5] gpio: samsung: Use CONFIG_ARCH_S3C64XX to check for
 S3C64xx support
In-Reply-To: <1380392497-27406-2-git-send-email-tomasz.figa@gmail.com>
References: <1380392497-27406-1-git-send-email-tomasz.figa@gmail.com>
 <1380392497-27406-2-git-send-email-tomasz.figa@gmail.com>
Message-ID: <CACRpkdZXOGpTspPucd=d0=Ws9Ccx19h4UYTTdgZceoofhuq0Kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 28, 2013 at 8:21 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:

> Since CONFIG_PLAT_S3C64XX is going to be removed, this patch modifies
> the gpio-samsung driver to use the proper way of checking for S3C64xx
> support - CONFIG_ARCH_S3C64XX.
>
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I assume that this will go through ARM SoC?

Yours,
Linus Walleij
