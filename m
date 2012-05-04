From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 04 May 2012 22:18:34 +0100
Subject: [PATCH 04/15] drivers/net: Do not free an IRQ if its request
 failed
In-Reply-To: <CACRpkdaB+mAmo50uSDvVcq=V9_BF01-zu2WHUU+cc2WPU1NEXA@mail.gmail.com>
References: <1334867804-31942-1-git-send-email-lee.jones@linaro.org>
 <1334867804-31942-5-git-send-email-lee.jones@linaro.org>
 <4FA3E35B.3000604@linaro.org>
 <CACRpkdaB+mAmo50uSDvVcq=V9_BF01-zu2WHUU+cc2WPU1NEXA@mail.gmail.com>
Message-ID: <4FA447AA.7030809@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/05/12 19:22, Linus Walleij wrote:
> On Fri, May 4, 2012 at 4:10 PM, Lee Jones<lee.jones@linaro.org>  wrote:
>> On 19/04/12 21:36, Lee Jones wrote:
>
>>> -               goto out_free_irq;
>>> +               goto out_disable_resources;
>>>         }
>>>
>>>         retval = register_netdev(dev);
>>
>>
>> Anything on this from the Net guys?
>
> This was merged for 3.4-rc5, check:
> https://lkml.org/lkml/2012/4/29/2

I actually found that out a few hours ago by accident.

Thanks for letting me know though.

Kind regards,
Lee

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
