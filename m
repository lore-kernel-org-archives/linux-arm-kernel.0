From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 04 Jun 2015 11:05:47 +0900
Subject: [PATCH 01/11] ARM: dt: Add SPI CS on Samsung Snow board.
In-Reply-To: <d47abe28c751b54b839d9340269a2c06a6e23a6c.1433364398.git.hramrach@gmail.com>
References: <cover.1433364398.git.hramrach@gmail.com>
 <d47abe28c751b54b839d9340269a2c06a6e23a6c.1433364398.git.hramrach@gmail.com>
Message-ID: <556FB27B.2090302@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04.06.2015 06:26, Michal Suchanek wrote:
> Although there is only one choice of chipselect it is necessary to
> specify it. The driver cannot claim the gpio otherwise.
> 
> Signed-off-by: Michal Suchanek <hramrach@gmail.com>
> ---
>  arch/arm/boot/dts/exynos5250-snow.dts | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
