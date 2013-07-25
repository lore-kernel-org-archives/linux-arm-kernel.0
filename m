From: zonque@gmail.com (Daniel Mack)
Date: Thu, 25 Jul 2013 11:00:30 +0200
Subject: [PATCH 1/5] gpio: pxa: remove dead code
In-Reply-To: <CAD6h2NS0p-kMUGyhbr93vd_oLSNyaB572riFB8mHt1cu5f-bGw@mail.gmail.com>
References: <1373555877-29887-1-git-send-email-zonque@gmail.com>
 <1373555877-29887-2-git-send-email-zonque@gmail.com>
 <CACRpkdaB7JnWzoLKpQ1eLWAi7yFz9CanhbhwtiCnEtcNWzX3RQ@mail.gmail.com>
 <CAD6h2NS0p-kMUGyhbr93vd_oLSNyaB572riFB8mHt1cu5f-bGw@mail.gmail.com>
Message-ID: <51F0E92E.6060900@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22.07.2013 09:14, Haojian Zhuang wrote:
> On 22 July 2013 00:15, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Thu, Jul 11, 2013 at 5:17 PM, Daniel Mack <zonque@gmail.com> wrote:
>>
>>> Commit f87311743 ("ARM: mmp: add more compatible names in gpio driver")
>>> changed the driver logic to determine the number of available GPIOs from
>>> the compatible string, and hence obsoleted the (undocumented) child
>>> nodes that were previously necessary. However, it left some remainder
>>> which can be safely removed now.
>>>
>>> Also, this patch makes pxa_gpio_probe_dt() return the correct value in
>>> case irq_alloc_descs() fails.
>>>
>>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>>> Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
>>> Cc: Linus Walleij <linus.walleij@linaro.org>
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>
>> Tentatively applied, Haojian, does this look allright?
>>
>> Yours,
>> Linus Walleij
> 
> This patch is good.
> 
> Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
> 

And what about the others? I think the first 3 patches of this series
can go through Linus W, and the other 2 should end up in the pxa tree,
right?


Thanks,
Daniel
