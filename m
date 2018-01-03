From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 3 Jan 2018 18:10:40 +0100
Subject: [PATCH 0/3] irqchip: irq-bcm2836: add support for DT interrupt
 polarity
In-Reply-To: <a7939fae-31d1-c743-5957-d88be98a0c63@arm.com>
References: <1513024752-11246-1-git-send-email-stefan.wahren@i2se.com>
 <d0c81267-8379-d4a1-ec56-fec3492c1df6@i2se.com>
 <a7939fae-31d1-c743-5957-d88be98a0c63@arm.com>
Message-ID: <60587e4d-d285-34e7-3d27-ea1daa1f97d1@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,


Am 19.12.2017 um 17:36 schrieb Marc Zyngier:
> On 19/12/17 07:02, Stefan Wahren wrote:
>> Hi Marc,
>>
>> Am 11.12.2017 um 21:39 schrieb Stefan Wahren:
>>> This patch series implements DT polarity support for the 1st level interrupt
>>> controller.
>>>
>>> Stefan Wahren (3):
>>>     dt-bindings: bcm2836-l1-intc: add interrupt polarity support
>>>     irqchip: irq-bcm2836: add support for DT interrupt polarity
>>>     ARM: dts: bcm283x: Define polarity of per-cpu interrupts
>>>
>>>    .../interrupt-controller/brcm,bcm2836-l1-intc.txt  |  4 +-
>>>    arch/arm/boot/dts/bcm2836.dtsi                     | 14 +++----
>>>    arch/arm/boot/dts/bcm2837.dtsi                     | 12 +++---
>>>    arch/arm/boot/dts/bcm283x.dtsi                     |  1 +
>>>    drivers/irqchip/irq-bcm2836.c                      | 46 +++++++++++++---------
>>>    5 files changed, 44 insertions(+), 33 deletions(-)
>>>
>> is this series okay?
> Yes, it does look good. I'll queue that for 4.16.
>
> Thanks,
>
> 	M.

since i didn't found this in linux-next, please take this as a gentle 
reminder.

Thanks
Stefan
