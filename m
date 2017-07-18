From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 18 Jul 2017 07:07:10 +0200
Subject: [PATCH 2/2] arm64: dts: exynos: Add extcon property for TM2 and
 TM2E
In-Reply-To: <1497942745-8607-3-git-send-email-dwoo08.lee@samsung.com>
References: <1497942745-8607-1-git-send-email-dwoo08.lee@samsung.com>
 <CGME20170620071232epcas1p44dcc6475c7f826a8da52ad776759a926@epcas1p4.samsung.com>
 <1497942745-8607-3-git-send-email-dwoo08.lee@samsung.com>
Message-ID: <20170718050710.GC13779@kozik-book>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 20, 2017 at 04:12:24PM +0900, Dongwoo Lee wrote:
> Since commit 9840354ff429 ("usb: dwc3: Add dual-role support") dwc3
> node requires extcon property to be initialized as otg mode, and it
> can support dual-role mode operation.
> 
> Signed-off-by: Dongwoo Lee <dwoo08.lee@samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 

Thanks, applied.

Best regards,
Krzysztof
