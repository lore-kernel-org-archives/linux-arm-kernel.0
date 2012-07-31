From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 31 Jul 2012 15:03:47 +0200
Subject: [PATCH V2 2/5] include/video: Add Exynos5 specific FIMD register
 offsets
In-Reply-To: <5017D4D7.3040303@mvista.com>
References: <1343737385-23337-1-git-send-email-l.krishna@samsung.com>
 <1343737385-23337-3-git-send-email-l.krishna@samsung.com>
 <5017D4D7.3040303@mvista.com>
Message-ID: <5017D7B3.1080001@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 07/31/2012 02:51 PM, Sergei Shtylyov wrote:
>> +/*EXYNOS5 FIMD REG OFFSET */

How about changing it to, e.g.

/* EXYNOS5 specific register offset definitions */

(but just in case you happen to resend this patch series)

>> +#define EXYNOS5_VIDTCON0    (0x20010)
>> +#define EXYNOS5_VIDTCON1    (0x20014)
>> +#define EXYNOS5_VIDTCON2    (0x20018)
>> +#define EXYNOS5_VIDTCON3    (0x2001C)
>> +#define EXYNOS5_VIDCON1        (0x20004)
> 
>    Parens not needed around simple literals.

Yes, I agree it looks insane. But, I think we could allow
this for consistency with the remaining definitions.

-- 

Regards,
Sylwester
