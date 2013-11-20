From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 20 Nov 2013 10:03:36 +0100
Subject: [PATCH 2/2] clksrc: delete nomadik MTU non-DT boot path
In-Reply-To: <CACRpkdbZeHDj_jgcJ7QH_+mwQqP6ZaKqGNjP6j37txAeq2DnsQ@mail.gmail.com>
References: <1384896499-9428-1-git-send-email-linus.walleij@linaro.org>	<528BE9C1.8000409@linaro.org>	<20131120085218.GE19953@lee--X1>	<528C79E5.2020209@linaro.org>
 <CACRpkdbZeHDj_jgcJ7QH_+mwQqP6ZaKqGNjP6j37txAeq2DnsQ@mail.gmail.com>
Message-ID: <528C7AE8.1040204@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2013 10:01 AM, Linus Walleij wrote:
> On Wed, Nov 20, 2013 at 9:59 AM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>> On 11/20/2013 09:52 AM, Lee Jones wrote:
>
>>>> A sidenote: there is a comment in arch/arm/mach-ux500/timer.c
>>>> "/* TODO: Once MTU has been DT:ed place code above into else. */"
>>>> but I did not see any changes related to this TODO.
>>>
>>> You mean similar to this one:
>>>     https://lkml.org/lkml/2013/11/6/118
>>
>> Yes :)
>
> It's applied in my tree as well, problem solved!

Ok, cool.

Thanks !
   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
