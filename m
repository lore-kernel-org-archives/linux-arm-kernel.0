From: robherring2@gmail.com (Rob Herring)
Date: Wed, 21 May 2014 10:29:16 -0500
Subject: [PATCH 00/10] ARM: Versatile irq and clock DT support
In-Reply-To: <5859481.dtUsNDpXQt@wuerfel>
References: <1400620176-7239-1-git-send-email-robherring2@gmail.com>
 <5859481.dtUsNDpXQt@wuerfel>
Message-ID: <CAL_JsqLXgi6+e=8GyHxt2Td3z3z8RWeTamNq+YCN1StT78zqiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 21, 2014 at 3:26 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 20 May 2014 16:09:26 Rob Herring wrote:
>> From: Rob Herring <robh@kernel.org>
>>
>> This series is some preparation work to fully convert Versatile platform
>> to DT. This converts the IRQ initialization to DT based init and adds
>> clocks to the Versatile DT. This doesn't actually enable using common
>> clock framework, but that is only a matter of removing the old clock
>> code and enabling the appropriate Kconfig options. This will be done
>> when Versatile can be completely converted over to DT boot. I have that
>> working in my tree, but full DT conversion is also dependent on DT PCI
>> support.
>>
>> I've tested under QEMU and Linus Walleij has tested an earlier version
>> on Versatile AB h/w.
>
> Looks great to me.
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> Should we merge it directly into arm-soc or are you planning to
> send a pull request?

I'll do a pull req. I'll give it a few more days for review.

Rob
