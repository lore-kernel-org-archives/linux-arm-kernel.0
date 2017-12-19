From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 19 Dec 2017 18:50:46 +0000
Subject: [PATCH 0/3] irqchip: irq-bcm2836: add support for DT interrupt
 polarity
In-Reply-To: <8737461ry0.fsf@anholt.net>
References: <1513024752-11246-1-git-send-email-stefan.wahren@i2se.com>
 <d0c81267-8379-d4a1-ec56-fec3492c1df6@i2se.com>
 <a7939fae-31d1-c743-5957-d88be98a0c63@arm.com> <8737461ry0.fsf@anholt.net>
Message-ID: <97a68b71-2e62-13ba-72ac-575c3b68617a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/12/17 18:41, Eric Anholt wrote:
> Marc Zyngier <marc.zyngier@arm.com> writes:
> 
>> On 19/12/17 07:02, Stefan Wahren wrote:
>>> Hi Marc,
>>>
>>> Am 11.12.2017 um 21:39 schrieb Stefan Wahren:
>>>> This patch series implements DT polarity support for the 1st level interrupt
>>>> controller.
>>>>
>>>> Stefan Wahren (3):
>>>>    dt-bindings: bcm2836-l1-intc: add interrupt polarity support
>>>>    irqchip: irq-bcm2836: add support for DT interrupt polarity
>>>>    ARM: dts: bcm283x: Define polarity of per-cpu interrupts
>>>>
>>>>   .../interrupt-controller/brcm,bcm2836-l1-intc.txt  |  4 +-
>>>>   arch/arm/boot/dts/bcm2836.dtsi                     | 14 +++----
>>>>   arch/arm/boot/dts/bcm2837.dtsi                     | 12 +++---
>>>>   arch/arm/boot/dts/bcm283x.dtsi                     |  1 +
>>>>   drivers/irqchip/irq-bcm2836.c                      | 46 +++++++++++++---------
>>>>   5 files changed, 44 insertions(+), 33 deletions(-)
>>>>
>>>
>>> is this series okay?
>>
>> Yes, it does look good. I'll queue that for 4.16.
> 
> Are you grabbing all 3, or should I be grabbing the DT one?

All 3, if that's OK with you.

	M.
-- 
Jazz is not dead. It just smells funny...
