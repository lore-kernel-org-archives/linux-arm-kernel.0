From: uri.mashiach@compulab.co.il (Uri Mashiach)
Date: Thu, 7 Jan 2016 13:20:28 +0200
Subject: [PATCH v4 3/3] wlcore/wl12xx: spi: add wifi support to cm-t335
In-Reply-To: <87io35lq2p.fsf@kamboji.qca.qualcomm.com>
References: <1451482533-8624-1-git-send-email-uri.mashiach@compulab.co.il>
 <1451482533-8624-4-git-send-email-uri.mashiach@compulab.co.il>
 <87io35lq2p.fsf@kamboji.qca.qualcomm.com>
Message-ID: <568E49FC.3090808@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kalle Valo,

On 01/07/2016 11:02 AM, Kalle Valo wrote:
> Uri Mashiach <uri.mashiach@compulab.co.il> writes:
>
>> Device tree modifications:
>> - Pinmux for SPI0 and WiFi GPIOs.
>> - SPI0 node with wlcore as a child node.
>>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Signed-off-by: Uri Mashiach <uri.mashiach@compulab.co.il>
>> ---
>> v1 -> v2: Replace interrupts and interrupt-parent with interrupts-extended.
>> v2 -> v3: Move the pinctrl-0 = <&wifi_pins> to the wlcore node.
>> v3 -> v4: replace interrupts-extended with interrupts and interrupt-parent. (revert v2 modification).
>>            According to Rob Herring and Documentation/devicetree/bindings/interrupt-controller/interrupts.txt,
>> 	  interrupts-extended should only be used when a device has multiple interrupt parents.
>>
>>   arch/arm/boot/dts/am335x-cm-t335.dts | 55 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 55 insertions(+)
>
> To what tree should this patch go? My wireless-drivers-next tree doesn't
> even have this file.

Should be applied into omap-for-v4.x/dt

>
> https://patchwork.kernel.org/patch/7933441/
>

-- 
Thanks,
Uri
