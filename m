From: yixun.lan@amlogic.com (Yixun Lan)
Date: Fri, 17 Nov 2017 21:47:14 +0800
Subject: [PATCH 1/5] dt-bindings: i2c: update documentation for the
 Meson-AXG
In-Reply-To: <03c9ea24-5f8d-f5dd-6e96-f53f56db530c@baylibre.com>
References: <20171117080236.32504-1-yixun.lan@amlogic.com>
 <20171117080236.32504-2-yixun.lan@amlogic.com>
 <03c9ea24-5f8d-f5dd-6e96-f53f56db530c@baylibre.com>
Message-ID: <dc339e2a-d8ab-7412-0c9e-bf4d052fc17e@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil


On 11/17/17 21:02, Neil Armstrong wrote:
> On 17/11/2017 09:02, Yixun Lan wrote:
>> From: Jian Hu <jian.hu@amlogic.com>
>>
>> Update the doc to explicitly add Meson-AXG to support list
>>
>> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>> ---
>>  Documentation/devicetree/bindings/i2c/i2c-meson.txt | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-meson.txt b/Documentation/devicetree/bindings/i2c/i2c-meson.txt
>> index 611b934c7e10..3097d2b44dad 100644
>> --- a/Documentation/devicetree/bindings/i2c/i2c-meson.txt
>> +++ b/Documentation/devicetree/bindings/i2c/i2c-meson.txt
>> @@ -2,6 +2,7 @@ Amlogic Meson I2C controller
>>  
>>  Required properties:
>>   - compatible: must be "amlogic,meson6-i2c" or "amlogic,meson-gxbb-i2c"
>> +						"amlogic,meson-axg-i2c"
> 
> Hi Yixun, Jian,
> 
> Maybe you should reformat by using :
> - compatible: must be :
> 	"amlogic,meson6-i2c" for Meson8 and compatible SoCs
> 	"amlogic,meson-gxbb-i2c" for GXBB and compatible SoCs
> 	"amlogic,meson-axg-i2c"for AXG and compatible SoCs
> 
> Neil
> 
sure, we can do this.
thanks for the review
>>   - reg: physical address and length of the device registers
>>   - interrupts: a single interrupt specifier
>>   - clocks: clock for the device
>>
> 
> .
> 
