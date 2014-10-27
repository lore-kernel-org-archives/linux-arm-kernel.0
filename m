From: suravee.suthikulpanit@amd.com (Suravee Suthikulanit)
Date: Mon, 27 Oct 2014 09:30:25 -0500
Subject: [PATCH] arm64: amd-seattle: Adding device tree for AMD Seattle
 platform
In-Reply-To: <544D00B1.7070703@suse.de>
References: <1414153221-13104-1-git-send-email-suravee.suthikulpanit@amd.com>
 <544D00B1.7070703@suse.de>
Message-ID: <544E5701.8000408@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/26/2014 9:09 AM, Andreas F?rber wrote:
> Hi,
>
> Am 24.10.2014 um 14:20 schrieb suravee.suthikulpanit at amd.com:
>> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
>> index f8001a6..6c27047 100644
>> --- a/arch/arm64/boot/dts/Makefile
>> +++ b/arch/arm64/boot/dts/Makefile
>> @@ -1,6 +1,7 @@
>>   dtb-$(CONFIG_ARCH_THUNDER) += thunder-88xx.dtb
>>   dtb-$(CONFIG_ARCH_VEXPRESS) += rtsm_ve-aemv8a.dtb foundation-v8.dtb
>>   dtb-$(CONFIG_ARCH_XGENE) += apm-mustang.dtb
>> +dtb-$(CONFIG_ARCH_SEATTLE) += amd-seattle.dtb
>
> It seems these lines are sorted alphabetically, so Seattle should go
> somewhere before Thunder.
>
>>
>>   targets += dtbs
>>   targets += $(dtb-y)
>
> Regards,
> Andreas
>

Ah.. right. I'll fix this and send out V2.

Suravee
