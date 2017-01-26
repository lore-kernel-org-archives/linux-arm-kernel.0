From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 26 Jan 2017 10:27:43 +0100
Subject: [PATCH 5/7] mfd: exynos-lpass: Remove pad retention control
In-Reply-To: <1485345031-2948-6-git-send-email-m.szyprowski@samsung.com>
References: <1485345031-2948-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170125115104eucas1p219f763cea7fdb2dfea092d1f2a28fc31@eucas1p2.samsung.com>
 <1485345031-2948-6-git-send-email-m.szyprowski@samsung.com>
Message-ID: <fc87bf0b-b746-8ad8-ade9-fbebec1acb19@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/25/2017 12:50 PM, Marek Szyprowski wrote:
> Pad retention should be controlled from pin control driver, so remove it
> from Exynos LPASS driver. After this change, no more access to PMU regmap
> is needed, so remove also the code for handling PMU regmap.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
