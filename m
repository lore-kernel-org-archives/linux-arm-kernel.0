From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 8 Jul 2016 22:23:49 +0200
Subject: [PATCH v2 1/7] bindings: spi-samsung: add exynos5433 spi
 compatible
In-Reply-To: <1467989201-14661-2-git-send-email-andi.shyti@samsung.com>
References: <1467989201-14661-1-git-send-email-andi.shyti@samsung.com>
 <1467989201-14661-2-git-send-email-andi.shyti@samsung.com>
Message-ID: <20160708202349.GA25980@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2016 at 11:46:35PM +0900, Andi Shyti wrote:
> The samsung,exynos5433-spi has some peculiarities that bring the
> need of creating a new compatible in the binding.
> 
> One of those is the 3-clocks controller management where the spi
> is fed with three clocks: "spi", "busclkN" and "ioclk".
> 
> By adding the exynos5433-spi, we deprecate the exynos7 compatible
> and discourage its use.
> 
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-samsung.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
