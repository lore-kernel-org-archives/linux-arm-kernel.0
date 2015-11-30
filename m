From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 01 Dec 2015 08:48:32 +0900
Subject: [PATCH 01/10] Input: s3c2410_ts: fix S3C_ADC dependency
In-Reply-To: <1448467615-447097-2-git-send-email-arnd@arndb.de>
References: <1448467615-447097-1-git-send-email-arnd@arndb.de>
 <1448467615-447097-2-git-send-email-arnd@arndb.de>
Message-ID: <565CE050.3030706@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26.11.2015 01:06, Arnd Bergmann wrote:
> S3C_ADC is only available on machines that don't do ARCH_MULTIPLATFORM,
> so changing the 'select' into 'depends on' here helps us move to
> ARCH_MULTIPLATFORM without introducing regressions.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/touchscreen/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
