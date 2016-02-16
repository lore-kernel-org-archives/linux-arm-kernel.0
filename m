From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 16 Feb 2016 18:03:14 +0100
Subject: [PATCH v3 05/12] arm64: add mvebu architecture entry
In-Reply-To: <20160216141212.00f037e5@xhacker> (Jisheng Zhang's message of
 "Tue, 16 Feb 2016 14:12:12 +0800")
References: <1454951660-13289-1-git-send-email-gregory.clement@free-electrons.com>
 <1454951660-13289-6-git-send-email-gregory.clement@free-electrons.com>
 <20160216141212.00f037e5@xhacker>
Message-ID: <87a8n0twod.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jisheng,
 
 On mar., f?vr. 16 2016, Jisheng Zhang <jszhang@marvell.com> wrote:

> Dear Gregory,
>
> On Mon, 8 Feb 2016 18:14:13 +0100 Gregory CLEMENT wrote:
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
>> index 21074f674bde..c621e69ed170 100644
>> --- a/arch/arm64/Kconfig.platforms
>> +++ b/arch/arm64/Kconfig.platforms
>> @@ -1,5 +1,11 @@
>>  menu "Platform selection"
>>  
>> +config ARCH_MVEBU
>
> it's better to keep ARCH_YYZZ sorted in alphabetic order


Yes I should have move the entry when I renamed it.

I will sent a v4 soon for this point.

Gregory

>
> Thanks,
> Jisheng
>
>> +	bool "Marvell EBU SoC Family"
>> +	help
>> +	  This enables support for Marvell EBU family such as the
>> +	  Armada 3700 SoC family.
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
