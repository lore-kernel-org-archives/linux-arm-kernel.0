From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 21 Apr 2016 09:19:39 +0200
Subject: [PATCH v2 2/2] i2c: s3c2410: Check clk_prepare_enable() return
 value
In-Reply-To: <1461163076-5959-2-git-send-email-javier@osg.samsung.com>
References: <1461163076-5959-1-git-send-email-javier@osg.samsung.com>
 <1461163076-5959-2-git-send-email-javier@osg.samsung.com>
Message-ID: <57187F0B.3000002@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/20/2016 04:37 PM, Javier Martinez Canillas wrote:
> The clk_prepare_enable() function can fail so check the return
> value and propagate the error in case of a failure.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> ---
> 
> Changes in v2:
> - Don't print the errno code since that's already printed by the
>   core when probe fails. Suggested by Krzysztof Kozlowski.
> 
>  drivers/i2c/busses/i2c-s3c2410.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)


Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Tested on Trats2 (Exynos4412, samsung,s3c2440-i2c)
Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
