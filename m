From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 23 May 2018 17:29:56 +0100
Subject: [PATCH 0/3] irqchip: meson-gpio: add support for Meson-AXG SoCs
In-Reply-To: <0c97c61b-c05b-21cf-c880-80cff04ed6f2@amlogic.com>
References: <20180408145700.23520-1-yixun.lan@amlogic.com>
 <0c97c61b-c05b-21cf-c880-80cff04ed6f2@amlogic.com>
Message-ID: <09d70e1f-abba-79d0-4dc3-7130fd0d07a8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/05/18 03:50, Yixun Lan wrote:
> Hi Marc (or anyone else)
> 
> On 04/08/18 22:56, Yixun Lan wrote:
>>   This series try to add GPIO interrupt controller support for Meson-AXG SoCs.
>>   The first patch is a trivial typo fix, I can fold the first two patches
>> together if necessary.
>>
>> Yixun Lan (3):
>>   dt-bindings: interrupt-controller: fix the double quotes
>>   dt-bindings: interrupt-controller: New binding for Meson-AXG SoC
>>   irqchip/meson-gpio: add support for Meson-AXG SoCs
>>
>>  .../bindings/interrupt-controller/amlogic,meson-gpio-intc.txt | 11 ++++++-----
>>  drivers/irqchip/irq-meson-gpio.c                              |  5 +++++
>>  2 files changed, 11 insertions(+), 5 deletions(-)
>>
> 
> please consider this merely a ping..
> will you take this series, or is there anything holding this?

Sure, I'll queue that for 4.18.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
