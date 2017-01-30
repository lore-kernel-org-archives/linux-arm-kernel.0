From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 30 Jan 2017 21:46:56 +0200
Subject: [PATCH v3 0/7] Pad retentions support for Exynos5433
In-Reply-To: <1485779908-32147-1-git-send-email-m.szyprowski@samsung.com>
References: <CGME20170130123837eucas1p13c607f81a1775a805740dccc87fe8b87@eucas1p1.samsung.com>
 <1485779908-32147-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20170130194656.mfyvq3bxzjnbkxg5@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2017 at 01:38:21PM +0100, Marek Szyprowski wrote:
> Hello,
> 
> This patchset is a first step to add support for all power domains on
> Exynos5433 SoCs. This patchset contains patches for Exynos pin control
> driver and Exynos LPASS MFD driver, which are needed to make the
> platform ready for adding power domains support.
> 
> Patches in this patchset depends on each other. They are order in such a
> way to make the changes bisectable.
> 
> Patch #2 has compile dependency on #1.
> Patch #3 has runtime dependency on commit fa59aa70907b2 ("soc: samsung:
> 	pmu: Add dummy support for Exynos5433 SoC",
> 	for-v4.11/drivers-soc-exynos-pmu-the-joy-never-ends branch).
> Patch #4 has runtime dependency on #3.
> Patch #5 has runtime dependency on commit 7547162ac3514 ("arm64: dts:
> 	exynos: Add clocks to Exynos5433 LPASS module, next/dt64 branch).
> 

Dependencies in samsung-soc tree, for those who need them, are:
 - tags/samsung-drivers-soc-pmu-4.11-2
 - tags/samsung-dt64-4.11-2

Repo: git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git

Best regards,
Krzysztof
