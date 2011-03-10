From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 10 Mar 2011 12:19:34 -0800
Subject: [PATCH 1/3] msm: 8660: Add clock control regions to iomap
In-Reply-To: <4D78F0D8.7000408@ru.mvista.com>
References: <1299732274-10742-1-git-send-email-sboyd@codeaurora.org>
	<1299732274-10742-2-git-send-email-sboyd@codeaurora.org>
	<4D78F0D8.7000408@ru.mvista.com>
Message-ID: <4D793256.5070904@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/10/2011 07:40 AM, Sergei Shtylyov wrote:
>
>> diff --git a/arch/arm/mach-msm/include/mach/msm_iomap-8x60.h
>> b/arch/arm/mach-msm/include/mach/msm_iomap-8x60.h
>> index 3b19b8f..ddfc85b 100644
>> --- a/arch/arm/mach-msm/include/mach/msm_iomap-8x60.h
>> +++ b/arch/arm/mach-msm/include/mach/msm_iomap-8x60.h
>> @@ -53,6 +53,14 @@
>>  #define MSM_TLMM_PHYS        0x00800000
>>  #define MSM_TLMM_SIZE        SZ_16K
>>
>> +#define MSM_CLK_CTL_BASE        IOMEM(0xFA010000)
>> +#define MSM_CLK_CTL_PHYS        0x00900000
>> +#define MSM_CLK_CTL_SIZE        SZ_16K
>
>    Surrounding code separates the macro names from values by tabs, and
> you're using spaces. Should be more consistent...

Thanks, will fix.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
