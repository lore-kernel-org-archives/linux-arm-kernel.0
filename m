From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 15 Aug 2017 07:58:35 +0100
Subject: [PATCH v5 3/9] mfd: tmio: Add partition parsers platform data
In-Reply-To: <1502743720-28672-4-git-send-email-andrea.adami@gmail.com>
References: <1502743720-28672-1-git-send-email-andrea.adami@gmail.com>
 <1502743720-28672-4-git-send-email-andrea.adami@gmail.com>
Message-ID: <20170815065835.jcuweb377lqioddc@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 14 Aug 2017, Andrea Adami wrote:

> With the introduction of sharpslpart partition parser we can now read the
> offsets from NAND: we specify the list of the parsers as platform data, with
> cmdlinepart and ofpart parsers first allowing to override the part. table
> written in NAND. This is done in the board files using this driver.
> 
> Thus, we need to extend tmio_nand_data to consider the partition parsers.
> 
> Signed-off-by: Andrea Adami <andrea.adami@gmail.com>
> ---
>  include/linux/mfd/tmio.h | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
