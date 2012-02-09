From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 09 Feb 2012 19:56:56 +0900
Subject: [PATCH 3/9] ARM: EXYNOS: add initial setup-i2c0 for EXYNOS5
In-Reply-To: <CAH9JG2UAPO6wfEaoTfOvu53x3whkLBjcM45SV4m7Pf4su7Gn2A@mail.gmail.com>
References: <1328024354-4277-1-git-send-email-kgene.kim@samsung.com>
 <1328024354-4277-4-git-send-email-kgene.kim@samsung.com>
 <CAH9JG2UAPO6wfEaoTfOvu53x3whkLBjcM45SV4m7Pf4su7Gn2A@mail.gmail.com>
Message-ID: <068c01cce719$8a69a600$9f3cf200$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> On 2/1/12, Kukjin Kim <kgene.kim@samsung.com> wrote:

[snip]

> > +	if (soc_is_exynos5250())
> > +		;
> > +		/* will be implemented with gpio function */
> Do you want to include both exynos4-gpio and exynos5-gpio?

Now, yes. But I think, I need to sort out the regarding gpio later.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
