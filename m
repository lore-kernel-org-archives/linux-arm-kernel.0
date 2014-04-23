From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 23 Apr 2014 20:09:30 +0800
Subject: [PATCH 0/4] pinctrl: sirf: switch to one gpiolib and
 gpiolib_irqchip helpers
In-Reply-To: <CACRpkdY6N3vh2-a5NwU0ZkXKsf8ArmxLBCL3dMrPTFwvN+x5JQ@mail.gmail.com>
References: <1397544229-20545-1-git-send-email-21cnbao@gmail.com>
 <CACRpkdY6N3vh2-a5NwU0ZkXKsf8ArmxLBCL3dMrPTFwvN+x5JQ@mail.gmail.com>
Message-ID: <CAGsJ_4zowXarh0xy2y4oTsTZbnKFDgMfA6JPTK+sSx6ew_Qw4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-04-23 5:47 GMT+08:00 Linus Walleij <linus.walleij@linaro.org>:
> On Tue, Apr 15, 2014 at 8:43 AM, Barry Song <21cnbao@gmail.com> wrote:
>
>> From: Barry Song <Baohua.Song@csr.com>
>>
>> This patchset depends on Linus Walleij's "pinctrl: sirf: rename inlined accessor".
>> and "pinctrl: sirf: switch driver to use gpiolib irqchip helpers" is rebased
>> from Linus Walleij's patch too.
>>
>> Barry Song (3):
>>   pinctrl: sirf: wrap all gpio banks into one gpio_chip
>>   gpio: make handler_data configurable while using gpiolib_irqchip
>>   pinctrl: sirf: move to use irq_get_handler_data
>> Linus Walleij (1):
>>   pinctrl: sirf: switch driver to use gpiolib irqchip helpers
>
> As mentioned I can't get this series to apply so please rebase,
> resend and take this opportunity to also add relevant ACKs.

linus, this patchset depends on your "pinctrl: sirf: rename inlined
accessor" you sent to me. it seems it is in neither your devel nor
3.5-rc2.

https://lkml.org/lkml/2014/4/8/156

>
> Yours,
> Linus Walleij

-barry
