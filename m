From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 03 Feb 2016 08:55:22 +0100
Subject: [PATCH 03/10] arm64: add Armada 3700 architecture entry
In-Reply-To: <20160203142451.41381ff6@xhacker> (Jisheng Zhang's message of
 "Wed, 3 Feb 2016 14:24:51 +0800")
References: <1454436468-4241-1-git-send-email-gregory.clement@free-electrons.com>
 <1454436468-4241-4-git-send-email-gregory.clement@free-electrons.com>
 <20160203142451.41381ff6@xhacker>
Message-ID: <87k2mm5itx.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jisheng,
 
 On mer., f?vr. 03 2016, Jisheng Zhang <jszhang@marvell.com> wrote:

> On Tue, 2 Feb 2016 19:07:41 +0100 Gregory CLEMENT wrote:
>
>> The Armada 3700 is an mvebu ARM64 SoC using one or two Cortex-A53 cores
>> depending of the variant.
>> 
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>> ---
>>  arch/arm64/Kconfig.platforms | 6 ++++++
>>  1 file changed, 6 insertions(+)
>> 
>> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
>> index 21074f674bde..7da341f7b90d 100644
>> --- a/arch/arm64/Kconfig.platforms
>> +++ b/arch/arm64/Kconfig.platforms
>> @@ -1,5 +1,11 @@
>>  menu "Platform selection"
>>  
>> +config ARCH_ARMADA_3700
>
> Would it be better to use ARCH_MVEBU? IMHO, there will be more ARMv8 SoCs
> from our EBU, do we plan to add one CONFIG_ARMADA_yyzz for each SoC?

Not for each SoC but for each family, yes. As we did for the other mvebu
SoC families.

Gregory

>
>> +	bool "Armada 3700 SoC Family"
>> +	help
>> +	  This enables support for Armada 3700 SoC Family. It is is an
>> +	  ARMv8 based chipset belonging to the mvebu family.
>> +
>>  config ARCH_BCM_IPROC
>>  	bool "Broadcom iProc SoC Family"
>>  	help
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
