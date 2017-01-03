From: andi.shyti@samsung.com (Andi Shyti)
Date: Tue, 03 Jan 2017 17:16:24 +0900
Subject: [PATCH 3/4] arm64: dts: exynos: make tm2 and tm2e independent from
 each other
In-Reply-To: <1483430237-26823-4-git-send-email-jcsing.lee@samsung.com>
References: <1483430237-26823-1-git-send-email-jcsing.lee@samsung.com>
 <CGME20170103075734epcas5p43a9743131f63affd0a438d2ed342f22e@epcas5p4.samsung.com>
 <1483430237-26823-4-git-send-email-jcsing.lee@samsung.com>
Message-ID: <20170103081624.wo3molbmpxtvafcz@gangnam.samsung>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> +	compatible = "samsung,tm2e", "samsung,exynos5433";

this is supposed to be "samsung,tm2".
Will wait for other comments and fix it in v2.

Andi
