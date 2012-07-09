From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 09 Jul 2012 22:42:37 +0200
Subject: [PATCH 7/9] Input: ab8500-ponkey: Create AB8500 domain IRQ mapping
In-Reply-To: <CACRpkdbB68mXuV3bx-gyJBdJCd2Ja86J8mvvmR3ez3dJ8SzOEg@mail.gmail.com>
References: <1341493572-29735-1-git-send-email-lee.jones@linaro.org>
 <4FF6994B.9040801@linaro.org> <20120706173957.GA10202@core.coreip.homeip.net>
 <4FFB288D.4080606@linaro.org> <20120709201422.GA12242@core.coreip.homeip.net>
 <4FFB40A4.5060505@linaro.org>
 <CACRpkdbB68mXuV3bx-gyJBdJCd2Ja86J8mvvmR3ez3dJ8SzOEg@mail.gmail.com>
Message-ID: <4FFB423D.1040606@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/07/12 22:37, Linus Walleij wrote:
> On Mon, Jul 9, 2012 at 10:35 PM, Lee Jones <lee.jones@linaro.org> wrote:
>
>> From: Lee Jones <lee.jones@linaro.org>
>> Date: Tue, 26 Jun 2012 10:46:50 +0100
>> Subject: [PATCH 1/1] Input: ab8500-ponkey: Create AB8500 domain IRQ mapping
>>
>> Before we can use any domain allocated IRQ, we need to first create a
>> map between the Hardware IRQ (hwirq) and the Linux Virtual IRQ (virq).
>> We do this with a helper function provided by the AB8500 IRQ domain
>> controller called ab8500_irq_get_virq(). We need to do this for both
>> IRQs which the Power-On-Key driver uses; one for button press, the other
>> for button depress.
>>
>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

I've just sent a new one following Dmitry's suggestion.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
