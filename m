From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 13 Sep 2013 10:15:58 +0200
Subject: [PATCH 0/8] IOP GPIO refactoring
In-Reply-To: <20130910141434.GD3379@blackmetal.musicnaut.iki.fi>
References: <1378741198-12847-1-git-send-email-linus.walleij@linaro.org>
 <20130910141434.GD3379@blackmetal.musicnaut.iki.fi>
Message-ID: <CACRpkdYbHTF0XGu-wLAeaw-nnSTEPh-ej9iizMbojmB8gzvb=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 10, 2013 at 4:14 PM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:

> With patch 6 it starts to crash on first gpio_get_value(), I guess
> because gpio-iop platform device is not registered on N2100...?

I think I've fixed this with the v2 versions of patches 1-3, you can
pull in and test the entire stack on Torvalds HEAD from here:

git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git iop-cleanup

Yours,
Linus Walleij
