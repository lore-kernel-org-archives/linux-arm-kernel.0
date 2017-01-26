From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 26 Jan 2017 10:36:30 +0100
Subject: [PATCH v2 5/8] mfd: exynos-lpass: Remove pad retention control
In-Reply-To: <1485419634-28331-6-git-send-email-m.szyprowski@samsung.com>
References: <1485419634-28331-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170126083403eucas1p2328ed884334b453ffb1faac3c745cec3@eucas1p2.samsung.com>
 <1485419634-28331-6-git-send-email-m.szyprowski@samsung.com>
Message-ID: <087a0ddf-75b2-b5a9-4bd5-374ac2901676@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/26/2017 09:33 AM, Marek Szyprowski wrote:
> Pad retention should be controlled from pin control driver, so remove it
> from Exynos LPASS driver. After this change, no more access to PMU regmap
> is needed, so remove also the code for handling PMU regmap.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Patches 5/8...8/8:

Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
