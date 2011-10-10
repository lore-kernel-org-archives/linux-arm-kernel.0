From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Oct 2011 10:18:39 +0200
Subject: [PATCH 2/2] pinmux: add a driver for the U300 pinmux
In-Reply-To: <15e5a354.4381.132e6876087.Coremail.hongjiujing@126.com>
References: <1317629883-13582-1-git-send-email-linus.walleij@stericsson.com>
	<CAGsJ_4wJogkvhoJ0JNJGbv9FvaA7zHxFKRwvkXdY0g5SbLXuJA@mail.gmail.com>
	<15e5a354.4381.132e6876087.Coremail.hongjiujing@126.com>
Message-ID: <CACRpkdZCDoiZEm=vX6xW52EbG4E-DMBvo8A3rF9T6TrfOX6O-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/10/9 tommy.hong <hongjiujing@126.com>:
> [Barry]
>>is?this?a?debug?information?or?do?you?want?it?to?be?in?mainline?
>>
> Hi,Barry,should dumpregs function need "CONFIG_XXX_DEBUG" when probe ?and if
> driver meet some issue or error,we can use dumpregs to trace?

You can add any debug stuff you want if it helps development
and/or transparance of the driver, but this stuff I just deleted, it
is not needed anymore. I just used it to figure out the default
reset-values of the registers.

Yours,
Linus Walleij
