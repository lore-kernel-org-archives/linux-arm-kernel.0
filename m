From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 23 Jul 2014 08:37:33 +0900
Subject: [PATCH 1/3] ARM: exynos: remove unused <mach/memory.h>
In-Reply-To: <CAOesGMgA0fc0_8JOOE01y=UKv-eAZuWiAkAKHG5iam0Zkhp9TA@mail.gmail.com>
References: <1404295043-6661-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20140722075138.GB28538@pengutronix.de>
 <CAOesGMgA0fc0_8JOOE01y=UKv-eAZuWiAkAKHG5iam0Zkhp9TA@mail.gmail.com>
Message-ID: <53CEF5BD.10307@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/23/14 01:14, Olof Johansson wrote:
> On Tue, Jul 22, 2014 at 12:51 AM, Uwe Kleine-K?nig
> <u.kleine-koenig@pengutronix.de>  wrote:
>> Hello,
>>
>> who takes care of this series?
>>
>> In fact they are all orthogonal to each other.
>>
>> The first patch
>>
>>          ARM: exynos: remove unused<mach/memory.h>
>>
>> has been reviewed and tested by Tomasz Figa and Sachin Kamat. Can the
>> Samsung people pick it up? Or armsoc?
>
> Kukjin should apply this one.
>
Oh, thanks for gentle reminder and I've applied into 2nd cleanup.

Thanks,
Kukjin


>> Patch 2 (v2!)
>>
>>          ARM: remove remaining definitions of PLAT_PHYS_OFFSET from<mach/memory.h>
>>
>> touches several arch/arm/mach-*/include/mach/memory.h and
>> arch/arm/Kconfig. armsoc? Russell?
>
> This can go through either, but Russell has already reviewed it once
> so send it to his patch tracker.
>
>> Patch 3 fixes a warning regarding nommu and touches the Kconfig entry
>> for Integrator and Renesas (non-multiplatform). armsoc?
>
> Don't know without seeing the patch. What's the patch subject so I can find it?
