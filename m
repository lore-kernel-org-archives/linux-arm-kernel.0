From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 25 Feb 2011 14:14:08 +0100
Subject: [PATCH] ARM: S5P: Add platform helpers for camera GPIO
	configuration
In-Reply-To: <1297447665-19492-2-git-send-email-s.nawrocki@samsung.com>
References: <1297447665-19492-1-git-send-email-s.nawrocki@samsung.com>
	<1297447665-19492-2-git-send-email-s.nawrocki@samsung.com>
Message-ID: <4D67AB20.8000000@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 02/11/2011 07:07 PM, Sylwester Nawrocki wrote:
> Add functions for the parallel camera GPIO interface
> configuration on S5PV210 and S5PV310 SoCs.
> 

Kukjin, are you OK with general concept of those?
I would probably need to rework the patches after recent
S5PV310 -> EXYNOS4 renaming. And move camera.h 
to arch/arm/plat-samsung/include/plat/?

What's your opinion?

Thanks,
-- 
Sylwester Nawrocki
Samsung Poland R&D Center
