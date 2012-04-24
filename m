From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 24 Apr 2012 09:00:23 +0100
Subject: [PATCH 10/15] drivers/gpio: represent gpio-nomadik as an IRQ
 controller in DT documentation
In-Reply-To: <CACRpkdbKEUS07jMoB4egLj6RpdyDfJMn_F2Q-VtzH9-YeaTJmw@mail.gmail.com>
References: <1334867804-31942-1-git-send-email-lee.jones@linaro.org>
 <1334867804-31942-11-git-send-email-lee.jones@linaro.org>
 <CACRpkdbKEUS07jMoB4egLj6RpdyDfJMn_F2Q-VtzH9-YeaTJmw@mail.gmail.com>
Message-ID: <4F965D97.3030005@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/04/12 08:57, Linus Walleij wrote:
> On Thu, Apr 19, 2012 at 10:36 PM, Lee Jones<lee.jones@linaro.org>  wrote:
>
>> Now gpio-nomadik has proper bindings devices initialised by Device Tree
>> entries are able to use the chained GPIO IRQ lines it provides. This
>> patch aims to reflect that in the gpio-nmk documentation.
>>
>> Signed-off-by: Lee Jones<lee.jones@linaro.org>
>> ---
>>   .../devicetree/bindings/gpio/gpio-nmk.txt          |    2 ++
>>   1 files changed, 2 insertions(+), 0 deletions(-)
>
> Thanks, applied to the ux500-devicetree branch.
>
> I will likely have to update the subject of each and every patch on
> this branch to reflect the fact that it's just touching the device
> tree files per se.

I don't have a problem with that.


-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
