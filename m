From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 16 Jan 2017 21:01:28 +0200
Subject: [PATCH 04/12] pinctrl: samsung: Document Exynos3250 SoC support
In-Reply-To: <1484549107-5957-5-git-send-email-m.szyprowski@samsung.com>
References: <1484549107-5957-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170116064525eucas1p123df65dedceef6e3efe255e9a2ec6d07@eucas1p1.samsung.com>
 <1484549107-5957-5-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20170116190128.nylf37ra6iio7ly4@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 16, 2017 at 07:44:59AM +0100, Marek Szyprowski wrote:
> Add missing compatible id for Exynos3250 SoC to device tree docs.
> Exynos pin control driver supports it since commit d97f5b9804bfcdc1
> ("pinctrl: exynos: Add driver data for Exynos3250").
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
