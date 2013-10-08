From: bcousson@baylibre.com (Benoit Cousson)
Date: Wed, 09 Oct 2013 00:40:10 +0200
Subject: [PATCH] ARM: dts: omap5-uevm: mark TWL6037 as
 system-power-controller
In-Reply-To: <52542813.7020208@ti.com>
References: <1379617896-15213-1-git-send-email-nm@ti.com>
 <52542813.7020208@ti.com>
Message-ID: <525489CA.10906@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nishanth,

On 08/10/2013 17:43, Nishanth Menon wrote:
> On 09/19/2013 02:11 PM, Nishanth Menon wrote:
>> This allows the palmas pm_power_off to kick in on power off command
>> and switch off the board.
>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
>> Based on: (benoit's for_3.13/dts branch)
>> https://git.kernel.org/cgit/linux/kernel/git/bcousson/linux-omap-dt.git/log/?h=for_3.13/dts
>> This uses the support introduced by:
>> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=b81eec09a484c588ead035003ce7555ca8a9963a
>>
>>   arch/arm/boot/dts/omap5-uevm.dts |    1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
>> index da25a14..8227386 100644
>> --- a/arch/arm/boot/dts/omap5-uevm.dts
>> +++ b/arch/arm/boot/dts/omap5-uevm.dts
>> @@ -271,6 +271,7 @@
>>   		reg = <0x48>;
>>   		interrupt-controller;
>>   		#interrupt-cells = <2>;
>> +		ti,system-power-controller;
>>
>>   		extcon_usb3: palmas_usb {
>>   			compatible = "ti,palmas-usb-vid";
>>
> Gentle ping.
> patchworks link: https://patchwork.kernel.org/patch/2913111/

I've just applied it and pushed it to my branch.

Thanks,
Benoit
