From: andi.shyti@samsung.com (Andi Shyti)
Date: Fri, 03 Mar 2017 09:22:06 +0900
Subject: [PATCH v3 0/7] Fix the parse_dt of exynos dsi and remove the OF
 graph
In-Reply-To: <1488450019-6482-1-git-send-email-hoegeun.kwon@samsung.com>
References: <CGME20170302102112epcas5p476b30508bbaffbf1fe9781b941cd418f@epcas5p4.samsung.com>
 <1488450019-6482-1-git-send-email-hoegeun.kwon@samsung.com>
Message-ID: <20170303002206.zh56dsx7iuysg374@gangnam.samsung>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hoegeun,

> Hoegeun Kwon (7):
>   arm64: dts: exynos: Add the burst and esc clock frequency properties
>     for exynos5433 dts
>   arm: dts: Add the burst and esc clock frequency properties for
>     exynos3250 dts
>   arm: dts: Add the burst and esc clock frequency properties for
>     exynos4412 dts
>   arm: dts: Add the burst and esc clock frequency properties for
>     exynos4210 dts
>   drm/exynos: dsi: Fix the parse_dt function
>   arm64: dts: exynos: Remove the OF graph from DSI node
>   arm: dts: Remove the OF graph from DSI node

for all of them:

Reviewed-by: Andi Shyti <andi.shyti@samsung.com>

although I would have squashed patch 2, 3 and 4, but no need to
resend, unless someone else agrees.

Andi
