From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 9 Jul 2014 15:50:10 +0100
Subject: [PATCH v7 03/24] mfd: max77686: Don't define dummy function if
 OF isn't enabled
In-Reply-To: <1404505467-26526-4-git-send-email-javier.martinez@collabora.co.uk>
References: <1404505467-26526-1-git-send-email-javier.martinez@collabora.co.uk>
 <1404505467-26526-4-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <20140709145010.GE2635@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 04 Jul 2014, Javier Martinez Canillas wrote:

> When the CONFIG_OF option was not enabled, a dummy function
> max77686_i2c_parse_dt_pdata() was defined since this is called
> unconditionally on probe(). Just always define the real function
> and conditionally call it if CONFIG_OF is enabled instead.
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  drivers/mfd/max77686.c | 10 +---------

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
