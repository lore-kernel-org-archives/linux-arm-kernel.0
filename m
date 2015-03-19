From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 19 Mar 2015 09:27:02 +0100
Subject: [PATCH v2 1/2] pinctrl: Add support for Meson8b
In-Reply-To: <CAOQ7t2avzGJU=eMaPZ8ajGiw5CaO40pn9njpN=6quiH+pii7dw@mail.gmail.com>
References: <1426064430-5826-1-git-send-email-carlo@caione.org>
 <1426064430-5826-2-git-send-email-carlo@caione.org>
 <CACRpkday9fO9mSr03qSy0jT1bG+Vu9qE6FUd8eZqxdnicuBTYQ@mail.gmail.com>
 <CAOQ7t2avzGJU=eMaPZ8ajGiw5CaO40pn9njpN=6quiH+pii7dw@mail.gmail.com>
Message-ID: <CACRpkda-Cp=EO571ACKj=AS4pNn3-Yq8MJ2VQ82_Y_iE3QLi0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 17, 2015 at 3:10 PM, Carlo Caione <carlo@caione.org> wrote:
> On Tue, Mar 17, 2015 at 12:49 PM, Linus Walleij
> <linus.walleij@linaro.org> wrote:

>>> +#ifndef _DT_BINDINGS_MESON8B_GPIO_H
>>> +#define _DT_BINDINGS_MESON8B_GPIO_H
>>> +
>>> +#include <dt-bindings/gpio/meson8-gpio.h>
>>
>> Why is this file including itself?
>
> It's not, the file is called meson8b-gpio.h and it's including meson8-gpio.h

Aha I was totally lost, sorry...

Yours,
Linus Walleij
