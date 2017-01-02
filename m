From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 2 Jan 2017 16:34:37 +0530
Subject: [PATCH v7 1/5] ARM: dts: da850: rename the display node label
In-Reply-To: <750eaa32-ca29-b140-eec6-cec4350cf304@ti.com>
References: <1481623759-12786-1-git-send-email-bgolaszewski@baylibre.com>
 <1481623759-12786-2-git-send-email-bgolaszewski@baylibre.com>
 <750eaa32-ca29-b140-eec6-cec4350cf304@ti.com>
Message-ID: <cb0e2aad-b63e-923a-bd63-26f059eeb05e@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 December 2016 03:27 PM, Tomi Valkeinen wrote:
> On 13/12/16 12:09, Bartosz Golaszewski wrote:
>> The tilcdc node name is 'display' as per the ePAPR 1.1 recommendation.
>> The label is also 'display', but change it to 'lcdc' to make it clear
>> what the underlying hardware is.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
>>  arch/arm/boot/dts/da850.dtsi | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
>> index 104155d..6b0ef3d 100644
>> --- a/arch/arm/boot/dts/da850.dtsi
>> +++ b/arch/arm/boot/dts/da850.dtsi
>> @@ -458,7 +458,7 @@
>>  			dma-names = "tx", "rx";
>>  		};
>>  
>> -		display: display at 213000 {
>> +		lcdc: display at 213000 {
>>  			compatible = "ti,da850-tilcdc";
>>  			reg = <0x213000 0x1000>;
>>  			interrupts = <52>;
>>
> 
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Applied with Tomi's reviewed-by.

Thanks,
Sekhar
