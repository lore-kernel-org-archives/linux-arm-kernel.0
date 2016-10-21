From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 21 Oct 2016 16:33:52 +0200
Subject: [RFC] ARM: dts: exynos: Remove exynos4415.dtsi
In-Reply-To: <1477059331-14586-1-git-send-email-krzk@kernel.org>
References: <CGME20161021141653eucas1p11801729a8cea77169d2639bbae6f0d6c@eucas1p1.samsung.com>
 <1477059331-14586-1-git-send-email-krzk@kernel.org>
Message-ID: <c8576159-347c-42df-6a8d-8620ba4be8a1@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/21/2016 04:15 PM, Krzysztof Kozlowski wrote:
> There are no boards in mainline using exynos4415.dtsi.  This is DTS
> was not tested for long.  I am also not aware of any popular out-of-tree
> boards using this (except consumer devices released by Samsung but those
> cannot use mainline).
> 
> Keeping Exynos4415 costs some useless effort so remove it.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

It seems a sane thing to do, I don't know of any active platform that
uses Exynos4415.

Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
