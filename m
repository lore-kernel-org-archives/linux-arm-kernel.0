From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 20 Nov 2013 09:59:17 +0100
Subject: [PATCH 2/2] clksrc: delete nomadik MTU non-DT boot path
In-Reply-To: <20131120085218.GE19953@lee--X1>
References: <1384896499-9428-1-git-send-email-linus.walleij@linaro.org>
 <528BE9C1.8000409@linaro.org> <20131120085218.GE19953@lee--X1>
Message-ID: <528C79E5.2020209@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2013 09:52 AM, Lee Jones wrote:
> On Tue, 19 Nov 2013, Daniel Lezcano wrote:
>
>> On 11/19/2013 10:28 PM, Linus Walleij wrote:
>>> Both platforms using the MTU (Nomadik and Ux500) have now been
>>> converted to use device tree exclusively, thus let us delete
>>> this platform data header and make this driver a fully
>>> self-contained DT-only driver.
>>>
>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Lee Jones <lee.jones@linaro.org>
>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>
>> A sidenote: there is a comment in arch/arm/mach-ux500/timer.c
>> "/* TODO: Once MTU has been DT:ed place code above into else. */"
>> but I did not see any changes related to this TODO.
>
> You mean similar to this one:
>    https://lkml.org/lkml/2013/11/6/118

Yes :)


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
