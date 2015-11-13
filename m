From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 13 Nov 2015 10:29:17 +0100
Subject: [PATCH v2 0/5] arm: dts: complete dm816x device tree
In-Reply-To: <20151112174706.GN3218@atomide.com>
References: <56449D1D.4030803@baylibre.com> <20151112174706.GN3218@atomide.com>
Message-ID: <5645AD6D.8010706@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/12/2015 06:47 PM, Tony Lindgren wrote:
> * Neil Armstrong <narmstrong@baylibre.com> [151112 06:08]:
>> In order to fix support for the dm816x platform, add missing bits in
>> the dm816x dtsi and cleanup OCP.
> 
> Which ones are needed as fixes for the v4.4-rc kernel?
> 
> Regards,
> 
> Tony
> 
>> The last patch adds support for the omap4-hwspinlock.
>>
>> v2: add ocp hwmod cleanup
>>
>> Neil Armstrong (5):
>>   arm: dts: add dm816x missing #mbox-cells
>>   arm: dts: add dm816x missing spi DT dma handles
Tony,

The two first are fixes for v4.4-rc.

>>   arm: dts: add dm816x pwm property to timers
>>   arm: dts: remove dm816x invalid DT l3_main hwmod
>>   arm: dts: Add omap4-hwspinlock support in dm816x

the 3 following can wait.

>>
>>  arch/arm/boot/dts/dm816x.dtsi | 20 +++++++++++++++++---
>>  1 file changed, 17 insertions(+), 3 deletions(-)
>>
>> -- 
>> 1.9.1

Thanks,
Neil
