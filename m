From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 11 May 2015 15:15:50 +0200
Subject: [PATCH 1/2] ARM: mvebu: add alias for mdio on Armada 38x
In-Reply-To: <554A17DE.7090702@free-electrons.com>
References: <1430918040-17307-1-git-send-email-kaloz@openwrt.org>
 <1430918040-17307-2-git-send-email-kaloz@openwrt.org>
 <554A17DE.7090702@free-electrons.com>
Message-ID: <5550AB86.1010400@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Imre,

On 06/05/2015 15:32, Gregory CLEMENT wrote:
> Hi Imre,
> 
> On 06/05/2015 15:13, Imre Kaloz wrote:
>> This allows us to reference it later.
>>
>> Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
> 
> Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

applied on mvebu/dt

Thanks,

Gregory

> 
> 
> Thanks,
> 
> Gregory
> 
>> ---
>>  arch/arm/boot/dts/armada-38x.dtsi | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
>> index ed2dd8b..839e5bf 100644
>> --- a/arch/arm/boot/dts/armada-38x.dtsi
>> +++ b/arch/arm/boot/dts/armada-38x.dtsi
>> @@ -495,7 +495,7 @@
>>  				status = "disabled";
>>  			};
>>  
>> -			mdio at 72004 {
>> +			mdio: mdio at 72004 {
>>  				#address-cells = <1>;
>>  				#size-cells = <0>;
>>  				compatible = "marvell,orion-mdio";
>>
> 
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
