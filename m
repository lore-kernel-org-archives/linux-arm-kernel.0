From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 3 Mar 2014 15:37:09 +0800
Subject: [PATCH 3/4] mfd: mc13xxx: Add missing spi_setup()
In-Reply-To: <1393746275-9253-3-git-send-email-shc_work@mail.ru>
References: <1393746275-9253-1-git-send-email-shc_work@mail.ru>
 <1393746275-9253-3-git-send-email-shc_work@mail.ru>
Message-ID: <20140303073709.GF4674@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The probe routine should call spi_setup() to configure the SPI bus
> so it can properly communicate with the device.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  drivers/mfd/mc13xxx-spi.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
