From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Thu, 5 Aug 2010 09:19:06 +0200
Subject: rfc: amba_pl022: LCD and AMBA PCLK clock updates
In-Reply-To: <1280851439-25468-1-git-send-email-wellsk40@gmail.com>
References: <1280851439-25468-1-git-send-email-wellsk40@gmail.com>
Message-ID: <AANLkTindQJLfTcw5oOY6EFjK=k29vGzAAYokO+_AJO7j@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/8/3  <wellsk40@gmail.com>:

> This patch series fixes unbalanced clock enables and disables for the
> pl11x driver and adds support for the AMBA PCLK via the AMBA bus driver.

I don't understand one thing of this, the subject says it's about PL022 (SPI),
this comment says it's for PL011 (serial) and then the patch is for CLCD...

I guess it's for the CLCD!

:-)

> This patch series depends on the AMBA PCLK patch..

That thing is already merged to the mainline kernel so no problem.

Yours,
Linus Walleij
