From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 5 Feb 2016 23:50:23 +0100
Subject: [PATCH v4 0/9] Add STM32 pinctrl/GPIO driver
In-Reply-To: <56A92FB0.7080907@gmail.com>
References: <1452773795-24216-1-git-send-email-mcoquelin.stm32@gmail.com>
 <CACRpkdYGQ1xObWfka2CN9au6YMGhpu4qcTZpu72bzuJjO38tog@mail.gmail.com>
 <56A92FB0.7080907@gmail.com>
Message-ID: <CACRpkdY81TqbOpP35i=+-x5fHbui+iZ6-bWnwRCZUZfz2-J+rw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2016 at 9:59 PM, Maxime Coquelin
<mcoquelin.stm32@gmail.com> wrote:

> How do you prefer to proceed?
> Should I send a fix on top of your devel branch, or you will fix it
> directly?

I fixed it now and also got rid of the surplus container_of
static inline. Sorry for the delay.

Yours,
Linus Walleij
