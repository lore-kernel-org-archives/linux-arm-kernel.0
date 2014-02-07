From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 7 Feb 2014 18:55:54 +0530
Subject: [PATCH v4] gpio: davinci: reuse for keystone soc
In-Reply-To: <CACRpkdbgteBtuwdEn+Bg+kA1JnEHus2FOfTbj-hm5fKBsw7XeA@mail.gmail.com>
References: <1391615244-12014-1-git-send-email-grygorii.strashko@ti.com>
 <CACRpkdbgteBtuwdEn+Bg+kA1JnEHus2FOfTbj-hm5fKBsw7XeA@mail.gmail.com>
Message-ID: <52F4DEE2.7030004@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Thursday 06 February 2014 06:50 PM, Linus Walleij wrote:
> On Wed, Feb 5, 2014 at 4:47 PM, Grygorii Strashko
> <grygorii.strashko@ti.com> wrote:
> 
>> The similar GPIO HW block is used by keystone SoCs as
>> in Davinci SoCs.
>> Hence, reuse Davinci GPIO driver for Keystone taking into
>> account that Keystone contains ARM GIC IRQ controller which
>> is implemented using IRQ Chip.
>>
>> Documentation:
>>         http://www.ti.com/lit/ug/sprugv1/sprugv1.pdf
>>
>> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> ---
>> Changes in v4:
>> - rebased on top of v3.14 +
>>   [patch] gpio: davinci: signedness bug in davinci_gpio_irq_setup()
> 
> Are you taking this through ARM SoC or is this something
> I should be merging?

Can you please merge this through your tree as there aren't any
dependencies with mach-davinci anymore.

Thanks,
Sekhar
