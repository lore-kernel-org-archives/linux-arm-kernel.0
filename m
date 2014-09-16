From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 16 Sep 2014 14:43:17 -0700
Subject: [PATCH v3 0/4] gpio: syscon: reuse for keystone 2 socs
In-Reply-To: <1409763935-5713-1-git-send-email-grygorii.strashko@ti.com>
References: <1409763935-5713-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <CACRpkdaB7YpYjuND+Dic2eM=0OB0Sk=gGRRd7QrQj1Ze1MYXaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 3, 2014 at 10:05 AM, Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> This series intended to integrate Keystone 2 DSP GPIO controller functionality
> into gpio-syscon driver (drivers/gpio/gpio-syscon.c) as requested
> by Linus Walleij in [1].

OK no comments on DT stuff etc for two weeks, so merged patches
1-3, the 4th you can take through the keystone git.

Yours,
Linus Walleij
