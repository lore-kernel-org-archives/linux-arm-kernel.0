From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 13 Nov 2014 11:40:05 +0900
Subject: [PATCH] ARM: EXYNOS: fix typo in static struct name
 "exynos5_list_diable_wfi_wfe"
In-Reply-To: <CABxcv==Hjfi+-Mt63YQaCtC3Wj12WFfU6biwmiVEFQvqAp3DBA@mail.gmail.com>
References: <1414489832-28011-1-git-send-email-pankaj.dubey@samsung.com>
 <CABxcv=nJ7-NoF-0EqCL=rk6hX2688iV98g=CiDADKT7QTNWBrw@mail.gmail.com>
 <CABxcv==Hjfi+-Mt63YQaCtC3Wj12WFfU6biwmiVEFQvqAp3DBA@mail.gmail.com>
Message-ID: <54641A05.9030107@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/11/14 18:54, Javier Martinez Canillas wrote:
> Hello Kukjin,
>
>>
>> After this patch, "[PATCH v9 1/2] ARM: EXYNOS: Add platform driver
>> support for Exynos PMU" [0] does not apply cleanly anymore.
>>
>
> I see that you already picked all the Exynos S2R patches on your
> v3.19-next/mach-exynos branch and also resolved that conflict.
>
Yes, but I couldn't merge it into -next because of some conflicts 
between for-next and mach-exynos branch at that time.

Note I've merged into -next just now, so if any problems in -next, 
please let us know.

> Is just that this branch was not merged in your for-next branch and
> that's why I didn't see the patches in linux-next.
>
> Sorry for the noise.

No problem, thanks.

- Kukjin
