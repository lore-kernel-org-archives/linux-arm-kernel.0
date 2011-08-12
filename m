From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 12 Aug 2011 19:18:53 +0900
Subject: [PATCH] ARM: EXYNOS4: Fix the IRQ definitions for MIPI CSIS device
In-Reply-To: <4E411BA4.2020909@ru.mvista.com>
References: <1312809118-6181-1-git-send-email-s.nawrocki@samsung.com>
	<4E411BA4.2020909@ru.mvista.com>
Message-ID: <008901cc58d9$3ea0b9d0$bbe22d70$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sergei Shtylyov wrote:
> 
> Hello.
> 
> On 08-08-2011 17:11, Sylwester Nawrocki wrote:
> 
> > This is a regression fix after migration to the external GIC.
> > The breakage has been introduced in commit:
> > "ARM: EXYNOS4: modify interrupt mappings for external GIC"
> 
>     Would be good to also cite that commit's ID for gitweb.
> 
Yes, I think so :)

Sylwester,
This is required now so I added commit id when I applied.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
