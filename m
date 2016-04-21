From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 21 Apr 2016 09:18:10 +0200
Subject: [PATCH v2 1/2] i2c: s3c2410: Print errno code in error logs
In-Reply-To: <1461163076-5959-1-git-send-email-javier@osg.samsung.com>
References: <1461163076-5959-1-git-send-email-javier@osg.samsung.com>
Message-ID: <57187EB2.70707@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/20/2016 04:37 PM, Javier Martinez Canillas wrote:
> The driver not always prints the error code in case of a failure but this
> information can be very useful for debugging. So let's print if available.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> ---
> 
> Hello,
> 
> This patch and 2/2 were only build tested because I don't have access to
> a board using this IP block. I just noticed these issues when comparing
> the i2c-s3c2410 driver with i2c-exynos5 where I did some fixes recently.
> 
> I think the patches are simple enough that is safe to pick them but of
> course testing will be highly appreciated.
> 
> Best regards,
> Javier
> 
> Changes in v2:
> - Don't print the errno code on probe since it's already printed by the
>   core. Suggested by Krzysztof Kozlowski.
> 
>  drivers/i2c/busses/i2c-s3c2410.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Tested on Trats2 (Exynos4412, samsung,s3c2440-i2c)
Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
