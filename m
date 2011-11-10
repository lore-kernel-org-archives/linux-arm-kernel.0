From: boyko.lee@samsung.com (Jongpill Lee)
Date: Thu, 10 Nov 2011 14:48:00 +0900
Subject: [PATCH V2 0/3] ASV support for Exynos4 series
Message-ID: <1320904083-19173-1-git-send-email-boyko.lee@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Each SoC has specification.For example voltage or ids current.
These values are related to production process.
If you have a good specification SoC, you can supply lower voltage into SoC.
Also, If your SoC has bad specification, you have to supply higher voltage into SoC.
So, after get these SoC specification value on initialize time, we can use these value to fix voltage for running SoC.
Using by this patch set, Exynos4210 can get SoC specification and adjust voltage.

[PATCH V2 1/3] ARM: EXYNOS4: Add ASV feature for Exynos4 series
[PATCH V2 2/3] ARM: EXYNOS4: Add clock for Exynos4210 asv feature
[PATCH V2 3/3] ARM: EXYNOS4: Support ASV for Exynos4210
