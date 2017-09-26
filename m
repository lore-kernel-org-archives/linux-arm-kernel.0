From: Wenyou.Yang@Microchip.com (Yang, Wenyou)
Date: Tue, 26 Sep 2017 09:02:15 +0800
Subject: [PATCH] ARM: dts: at91: sama5d2_xplained: Add charger node
In-Reply-To: <20170925201331.4qzewq3rahtrynt7@piout.net>
References: <20170815062420.21644-1-wenyou.yang@microchip.com>
 <20170925201331.4qzewq3rahtrynt7@piout.net>
Message-ID: <2d9a44a1-0657-e187-c512-8207919e3c79@Microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,


On 2017/9/26 4:13, Alexandre Belloni wrote:
> On 15/08/2017 at 14:24:20 +0800, Wenyou Yang wrote:
>> From: Wenyou Yang <wenyou.yang@atmel.com>
>>
>> Add the charger device node as a sub-device of act8945a mfd, move
>> the charger's properties in the node, and replace the
>> "active-semi,irq_gpios" with the "interrupts" property to denote
>> the act8945a charger's irq.
>>
>> Signed-off-by: Wenyou Yang <wenyou.yang@microchip.com>
>> ---
>>
>>   arch/arm/boot/dts/at91-sama5d2_xplained.dts | 23 +++++++++++++++--------
>>   1 file changed, 15 insertions(+), 8 deletions(-)
> Applied, now but I had to rework the patch a bit. Can you check this is
> working for you?
>
> https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git/commit/?h=at91-dt&id=4b6ad41f267b8ddabf5dd1b02a318bc74f0b95e9
It is okay for me.

Thanks a lot.

Best Regards,
Wenyou Yang
