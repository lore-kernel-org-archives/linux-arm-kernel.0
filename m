From: viresh.kumar@st.com (viresh kumar)
Date: Tue, 7 Sep 2010 14:06:36 +0530
Subject: [PATCH 12/74] ST SPEAr: Correcting SOC Config base address for
	spear320
In-Reply-To: <20100906225804.GE8153@game.jcrosoft.org>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<08862b0d4eeed76cbd151741a1582da7855ca452.1283161023.git.viresh.kumar@st.com>
	<20100906225804.GE8153@game.jcrosoft.org>
Message-ID: <4C85F994.10702@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/7/2010 4:28 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> Hi,
> 
> 	not relased to this patch series

Jean,

Current patch series is named "Updating SPEAr Support".
This patch is just an bug fix. Why shouldn't it be part of this series.

regards,
viresh

> On 16:08 Mon 30 Aug     , Viresh KUMAR wrote:
>> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
>> ---
>>  arch/arm/mach-spear3xx/include/mach/spear320.h |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-spear3xx/include/mach/spear320.h b/arch/arm/mach-spear3xx/include/mach/spear320.h
>> index cacf17a..53677e4 100644
>> --- a/arch/arm/mach-spear3xx/include/mach/spear320.h
>> +++ b/arch/arm/mach-spear3xx/include/mach/spear320.h
>> @@ -62,7 +62,7 @@
>>  #define SPEAR320_SMII1_BASE		0xAB000000
>>  #define SPEAR320_SMII1_SIZE		0x01000000
>>  
>> -#define SPEAR320_SOC_CONFIG_BASE	0xB4000000
>> +#define SPEAR320_SOC_CONFIG_BASE	0xB3000000
>>  #define SPEAR320_SOC_CONFIG_SIZE	0x00000070
>>  /* Interrupt registers offsets and masks */
>>  #define INT_STS_MASK_REG		0x04
>> -- 
>> 1.7.2.2
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> .
> 
