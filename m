From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 10 Oct 2016 02:07:08 -0700
Subject: [PATCH] ARM: dts: fix naming of pinctrl node
In-Reply-To: <6039a5f9-2b36-c427-2f8a-addf76cf1c26@broadcom.com>
References: <1475958866-15942-1-git-send-email-scott.branden@broadcom.com>
 <6039a5f9-2b36-c427-2f8a-addf76cf1c26@broadcom.com>
Message-ID: <e21a9568-2e98-1cee-94bb-004639bc8ab2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/08/2016 02:03 PM, Ray Jui wrote:
> 
> 
> On 10/8/2016 1:34 PM, Scott Branden wrote:
>> Remove 0x from pinctrl node to match device tree naming convention.
>>
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>> ---
>>  arch/arm/boot/dts/bcm-cygnus.dtsi | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi
>> b/arch/arm/boot/dts/bcm-cygnus.dtsi
>> index fabc9f3..539c58f 100644
>> --- a/arch/arm/boot/dts/bcm-cygnus.dtsi
>> +++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
>> @@ -108,7 +108,7 @@
>>              };
>>          };
>>
>> -        pinctrl: pinctrl at 0x0301d0c8 {
>> +        pinctrl: pinctrl at 0301d0c8 {
>>              compatible = "brcm,cygnus-pinmux";
>>              reg = <0x0301d0c8 0x30>,
>>                    <0x0301d24c 0x2c>;
>>
> 
> Looks good to me!
> 
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>

Applied, thanks!
-- 
Florian
