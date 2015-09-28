From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 28 Sep 2015 20:44:59 +0900
Subject: [PATCH 3/5] ARM: dts: S3C2416: fix cpu compatible value
In-Reply-To: <1443202534-13816-3-git-send-email-vz@mleia.com>
References: <1443202506-13732-1-git-send-email-vz@mleia.com>
 <1443202534-13816-3-git-send-email-vz@mleia.com>
Message-ID: <5609283B.1070306@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 26.09.2015 o 02:35, Vladimir Zapolskiy pisze:
> The change corrects cpu compatible property to a defined one,
> see Documentation/devicetree/bindings/arm/cpus.txt
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  arch/arm/boot/dts/s3c2416.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)


Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
