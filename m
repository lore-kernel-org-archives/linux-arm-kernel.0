From: robh@kernel.org (Rob Herring)
Date: Sun, 21 Feb 2016 20:55:04 -0600
Subject: [PATCH 2/3] thermal: exynos: Document number of supported
 trip-points
In-Reply-To: <1455772460-20684-2-git-send-email-k.kozlowski@samsung.com>
References: <1455772460-20684-1-git-send-email-k.kozlowski@samsung.com>
 <1455772460-20684-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20160222025504.GQ15973@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 18, 2016 at 02:14:19PM +0900, Krzysztof Kozlowski wrote:
> Document the number of configurable temperature thresholds (for
> trip-points in interrupt-driven mode).
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  Documentation/devicetree/bindings/thermal/exynos-thermal.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
