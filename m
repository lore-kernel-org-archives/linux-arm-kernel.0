From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 9 Jul 2014 15:53:46 +0100
Subject: [PATCH v7 05/24] mfd: max77686: Return correct error when pdata
 isn't found
In-Reply-To: <1404505467-26526-6-git-send-email-javier.martinez@collabora.co.uk>
References: <1404505467-26526-1-git-send-email-javier.martinez@collabora.co.uk>
 <1404505467-26526-6-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <20140709145346.GG2635@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 04 Jul 2014, Javier Martinez Canillas wrote:

> When platform data is not found an -EIO (I/O error) code is returned.
> This doesn't seem to be the correct error so better return -EINVAL
> (Invalid argument) which is what most drivers do in this case.
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  drivers/mfd/max77686.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
