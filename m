From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Sun, 17 Apr 2016 15:32:40 +0200
Subject: [PATCH v2 1/2] i2c: exynos5: Check clk_prepare_enable() return
 value
In-Reply-To: <1460855693-28225-1-git-send-email-javier@osg.samsung.com>
References: <1460855693-28225-1-git-send-email-javier@osg.samsung.com>
Message-ID: <20160417133240.GB3620@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 16, 2016 at 09:14:52PM -0400, Javier Martinez Canillas wrote:
> The clk_prepare_enable() function can fail so check the return value
> and propagate the error to the caller in case of a failure.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
> 
> Changes in v2: None
> 
>  drivers/i2c/busses/i2c-exynos5.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>


Hi,

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
