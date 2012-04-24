From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 24 Apr 2012 08:58:14 +0100
Subject: [PATCH 08/15] drivers/mmc: MMCI: Use correct GPIO binding for
 IRQ requests
In-Reply-To: <CACRpkdbirMq4hn0+0hWmugKx37egEBNobG+stD59xJFBJ4m2fg@mail.gmail.com>
References: <1334867804-31942-1-git-send-email-lee.jones@linaro.org>
 <1334867804-31942-9-git-send-email-lee.jones@linaro.org>
 <CACRpkdbirMq4hn0+0hWmugKx37egEBNobG+stD59xJFBJ4m2fg@mail.gmail.com>
Message-ID: <4F965D16.5030205@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/04/12 08:51, Linus Walleij wrote:
> On Thu, Apr 19, 2012 at 10:36 PM, Lee Jones<lee.jones@linaro.org>  wrote:
>
>> Now there are irqdomains in place for Snowball, we can request
>> GPIO IRQs directly by their binding. This replaces the previous method
>> of hard-coding the hwirq using u32 values in the DT.
>>
>> Signed-off-by: Lee Jones<lee.jones@linaro.org>
>
> Acked-by: Linus Walleij<linus.walleij@linaro.org>
>
> Why not squash this with the previous MMCI device tree patch and
> update it?

You mean the one I sent a couple of weeks ago?

I'd rather let that one sit in Russell's patch tracker and send this as 
an update, if it's all the same to you?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
