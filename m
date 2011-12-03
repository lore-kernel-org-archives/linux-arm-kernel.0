From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 03 Dec 2011 19:20:26 +0900
Subject: [PATCH V2 0/3] ASV support for Exynos4 series
In-Reply-To: <1320904083-19173-1-git-send-email-boyko.lee@samsung.com>
References: <1320904083-19173-1-git-send-email-boyko.lee@samsung.com>
Message-ID: <000701ccb1a5$2cfc3c70$86f4b550$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jongpill Lee wrote:
> 
> Each SoC has specification.For example voltage or ids current.
> These values are related to production process.
> If you have a good specification SoC, you can supply lower voltage into
> SoC.
> Also, If your SoC has bad specification, you have to supply higher voltage
> into SoC.
> So, after get these SoC specification value on initialize time, we can use
> these value to fix voltage for running SoC.
> Using by this patch set, Exynos4210 can get SoC specification and adjust
> voltage.
> 
> [PATCH V2 1/3] ARM: EXYNOS4: Add ASV feature for Exynos4 series
> [PATCH V2 2/3] ARM: EXYNOS4: Add clock for Exynos4210 asv feature
> [PATCH V2 3/3] ARM: EXYNOS4: Support ASV for Exynos4210

Hi Jongpill,

See my comments and then could you please rebase this series based on latest
my for-next?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
