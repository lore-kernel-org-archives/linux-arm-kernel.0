From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 03 Mar 2011 16:36:08 +0900
Subject: [PATCH] ARM: S5P: Add platform helpers for camera GPIO
	configuration
In-Reply-To: <4D67AB20.8000000@samsung.com>
References: <1297447665-19492-1-git-send-email-s.nawrocki@samsung.com>
	<1297447665-19492-2-git-send-email-s.nawrocki@samsung.com>
	<4D67AB20.8000000@samsung.com>
Message-ID: <01c601cbd975$c77cb170$56761450$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sylwester Nawrocki wrote:
> 
> 
> On 02/11/2011 07:07 PM, Sylwester Nawrocki wrote:
> > Add functions for the parallel camera GPIO interface
> > configuration on S5PV210 and S5PV310 SoCs.
> >
> 
> Kukjin, are you OK with general concept of those?
> I would probably need to rework the patches after recent
> S5PV310 -> EXYNOS4 renaming. And move camera.h
> to arch/arm/plat-samsung/include/plat/?
> 
> What's your opinion?

Oh, missed...yeah need to re-work based on exynos4 :)
And you don't need to move it into plat-samsung/ because plat-s5p/ is used
for Exynos also.

Please refer to my comments on it.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
