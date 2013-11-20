From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 20 Nov 2013 10:01:12 +0100
Subject: [PATCH 2/2] clksrc: delete nomadik MTU non-DT boot path
In-Reply-To: <528C79E5.2020209@linaro.org>
References: <1384896499-9428-1-git-send-email-linus.walleij@linaro.org>
 <528BE9C1.8000409@linaro.org> <20131120085218.GE19953@lee--X1>
 <528C79E5.2020209@linaro.org>
Message-ID: <CACRpkdbZeHDj_jgcJ7QH_+mwQqP6ZaKqGNjP6j37txAeq2DnsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 20, 2013 at 9:59 AM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 11/20/2013 09:52 AM, Lee Jones wrote:

>>> A sidenote: there is a comment in arch/arm/mach-ux500/timer.c
>>> "/* TODO: Once MTU has been DT:ed place code above into else. */"
>>> but I did not see any changes related to this TODO.
>>
>> You mean similar to this one:
>>    https://lkml.org/lkml/2013/11/6/118
>
> Yes :)

It's applied in my tree as well, problem solved!

Yours,
Linus Walleij
