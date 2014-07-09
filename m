From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 9 Jul 2014 15:52:03 +0100
Subject: [PATCH v7 04/24] mfd: max77686: Make platform data over-rule DT
In-Reply-To: <1404505467-26526-5-git-send-email-javier.martinez@collabora.co.uk>
References: <1404505467-26526-1-git-send-email-javier.martinez@collabora.co.uk>
 <1404505467-26526-5-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <20140709145203.GF2635@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 04 Jul 2014, Javier Martinez Canillas wrote:

> The function max77802_i2c_parse_dt_pdata() should only be called
> if there isn't already platform data for the device.
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  drivers/mfd/max77686.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I assume some of these patches can be applied independently.

Let me know which ones and I'll apply them.  In the mean time:

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
