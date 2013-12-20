From: jg1.han@samsung.com (Jingoo Han)
Date: Fri, 20 Dec 2013 11:36:48 +0900
Subject: [PATCH -next] spi: nuc900: remove redundant return value check of
 platform_get_resource()
In-Reply-To: <CAPgLHd9rWo=vAa5xiPhi_FFheGNMOTEvt_0_AFaxMyYEJ8TBrQ@mail.gmail.com>
References: <CAPgLHd9rWo=vAa5xiPhi_FFheGNMOTEvt_0_AFaxMyYEJ8TBrQ@mail.gmail.com>
Message-ID: <003101cefd2c$54f7d700$fee78500$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, December 20, 2013 11:22 AM, Wei Yongjun wrote:
> 
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Remove unneeded error handling on the result of a call
> to platform_get_resource() when the value is passed to
> devm_ioremap_resource().
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Reviewed-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
>  drivers/spi/spi-nuc900.c | 6 ------
>  1 file changed, 6 deletions(-)
