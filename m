From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 20 Nov 2013 19:43:23 +0530
Subject: [PATCH 1/2] gpio: davinci: Fix a check for unbanked gpio
In-Reply-To: <CACRpkdbeWa76n1yrLxLJUEaz116k+48EbRtPO2iz=y=WLYoR_Q@mail.gmail.com>
References: <1383893156-28010-1-git-send-email-prabhakar.csengg@gmail.com>	<1383893156-28010-2-git-send-email-prabhakar.csengg@gmail.com>	<5281C82B.9090402@ti.com>
 <CACRpkdbeWa76n1yrLxLJUEaz116k+48EbRtPO2iz=y=WLYoR_Q@mail.gmail.com>
Message-ID: <528CC383.8030104@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 November 2013 04:18 PM, Linus Walleij wrote:
> On Tue, Nov 12, 2013 at 7:18 AM, Sekhar Nori <nsekhar@ti.com> wrote:
>> On Friday 08 November 2013 12:15 PM, Prabhakar Lad wrote:
>>> From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
>>>
>>> This patch fixes a check for offset in gpio_to_irq_unbanked()
>>> and also assigns gpio_irq, gpio_unbanked of chips[0] to
>>> appropriate values which is used in gpio_to_irq_unbanked()
>>> function.
>>>
>>> Reported-by: Grygorii Strashko <grygorii.strashko@ti.com>
>>> Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
>>
>> You should note explicitly that this patch fixes broken unbanked IRQ
>> support. You mostly just described what you are doing.
>>
>> I will fixup while committing.
> 
> So you're carrying this patch Sekhar?

Yes, and I would have sent this for upstream already if not for I going
under the weather a bit past couple of days.

Thanks,
Sekhar
