From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 27 Jan 2016 21:20:27 +0100
Subject: [PATCH] pinctrl: pxa: export pxa2xx_pinctrl_init()
In-Reply-To: <CACRpkdai_HysVqroBz-NcupxRF_2PPyHQnj8e8Ani6+04xre0A@mail.gmail.com>
 (Linus Walleij's message of "Wed, 27 Jan 2016 13:33:23 +0100")
References: <1453577113-14423-1-git-send-email-yamada.masahiro@socionext.com>
 <CACRpkdai_HysVqroBz-NcupxRF_2PPyHQnj8e8Ani6+04xre0A@mail.gmail.com>
Message-ID: <87powm93lg.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> On Sat, Jan 23, 2016 at 8:25 PM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>
>> Building pinctrl-pxa27x.c as a module causes a link error:
>>
>> ERROR: "pxa2xx_pinctrl_init" [drivers/pinctrl/pxa/pinctrl-pxa27x.ko] undefined!
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Patch applied with Robert's ACK.
Thanks Linus.

Cheers.

-- 
Robert
