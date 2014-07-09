From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 9 Jul 2014 15:54:38 +0100
Subject: [PATCH v7 06/24] mfd: max77686: Make error checking consistent
In-Reply-To: <1404505467-26526-7-git-send-email-javier.martinez@collabora.co.uk>
References: <1404505467-26526-1-git-send-email-javier.martinez@collabora.co.uk>
 <1404505467-26526-7-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <20140709145438.GH2635@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 04 Jul 2014, Javier Martinez Canillas wrote:

> Error checking across the driver is mostly consistent besides
> a few exceptions, so change these exceptions for consistency.
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  drivers/mfd/max77686.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
