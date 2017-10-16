From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 16 Oct 2017 09:45:10 +0100
Subject: [PATCH v3 1/8] ARM: NOMMU: Move out MPU setup in separate module
In-Reply-To: <20171014142254.GG20805@n2100.armlinux.org.uk>
References: <1506330344-31556-1-git-send-email-vladimir.murzin@arm.com>
 <1506330344-31556-2-git-send-email-vladimir.murzin@arm.com>
 <20171014142254.GG20805@n2100.armlinux.org.uk>
Message-ID: <7313631c-36a2-15e5-368a-8ff0eb1b5322@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/10/17 15:22, Russell King - ARM Linux wrote:
> On Mon, Sep 25, 2017 at 10:05:37AM +0100, Vladimir Murzin wrote:
>> diff --git a/arch/arm/mm/pmsa-v7.c b/arch/arm/mm/pmsa-v7.c
>> new file mode 100644
>> index 0000000..ee3cf51
>> --- /dev/null
>> +++ b/arch/arm/mm/pmsa-v7.c
>> @@ -0,0 +1,262 @@
>> +/*
>> + *  linux/arch/arm/mm/nommu.c
>> + *
>> + * ARM uCLinux supporting functions.
> 
> If this is for "a different MPU model" wouldn't it be better to say here?
> uCLinux itself doesn't require a MPU (think pre-Cortex MMU-less systems.)
> 

Agree, content of this file it not related to uCLinux. I'll update a comment.

Thanks
Vladimir
