From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 26 Jan 2017 22:08:23 +0200
Subject: [PATCH v2 4/8] arm64: dts: exynos: Add clocks to Exynos5433
 LPASS module
In-Reply-To: <1485419634-28331-5-git-send-email-m.szyprowski@samsung.com>
References: <1485419634-28331-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170126083403eucas1p1ad75fe027047dc240b9afd651c7713a5@eucas1p1.samsung.com>
 <1485419634-28331-5-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20170126200823.eh6f6qubawawrtuy@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2017 at 09:33:50AM +0100, Marek Szyprowski wrote:
> Exynos5433 LPASS module requires some clocks for proper operation with
> power domain.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 

Thanks, applied to the same branch as other Exynos5433 changes. I can
provide a tag with it, just give me a couple of days. Anyway it will be
good if dependencies like this enter v4.11.

Best regards,
Krzysztof
