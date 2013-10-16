From: nm@ti.com (Nishanth Menon)
Date: Wed, 16 Oct 2013 08:27:16 -0500
Subject: [PATCH 1/2] ARM: dts: omap5-uevm: remove always_on, boot_on from
 smps10_out1
In-Reply-To: <525E9206.9010501@ti.com>
References: <1381402195-29257-1-git-send-email-kishon@ti.com>
 <525E9206.9010501@ti.com>
Message-ID: <525E9434.1090006@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/16/2013 08:17 AM, Kishon Vijay Abraham I wrote:
> Benoit,
> 
> On Thursday 10 October 2013 04:19 PM, Kishon Vijay Abraham I wrote:
>> smps10 should be enabled only in the case of host mode. So stop
>> doing always_on, boot_on from smps10_out1. The driver will enable it in host
>> mode.
> 
> Can you take this patch too?

Acked-by: Nishanth Menon <nm@ti.com>
> 
> Thanks
> Kishon
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  arch/arm/boot/dts/omap5-uevm.dts |    2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
>> index d784b3a..e06a04a 100644
>> --- a/arch/arm/boot/dts/omap5-uevm.dts
>> +++ b/arch/arm/boot/dts/omap5-uevm.dts
>> @@ -334,8 +334,6 @@
>>  					regulator-name = "smps10_out1";
>>  					regulator-min-microvolt = <5000000>;
>>  					regulator-max-microvolt = <5000000>;
>> -					regulator-always-on;
>> -					regulator-boot-on;
>>  				};
>>  
>>  				ldo1_reg: ldo1 {
>>
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Regards,
Nishanth Menon
