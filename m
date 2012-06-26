From: marex@denx.de (Marek Vasut)
Date: Tue, 26 Jun 2012 23:52:35 +0200
Subject: [PATCH v7 03/14] usb: chipidea: msm: add missing section
 annotation
In-Reply-To: <1340607391-16380-4-git-send-email-richard.zhao@freescale.com>
References: <1340607391-16380-1-git-send-email-richard.zhao@freescale.com>
 <1340607391-16380-4-git-send-email-richard.zhao@freescale.com>
Message-ID: <201206262352.35258.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Richard Zhao,

> From: Felipe Balbi <balbi@ti.com>
> 
> no functional changes, it will just free up some
> code if we don't have hotplug.

Well, start the sentence with a capital letter ;-)

Acked-by: Marek Vasut <marex@denx.de>
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> ---
>  drivers/usb/chipidea/ci13xxx_msm.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/chipidea/ci13xxx_msm.c
> b/drivers/usb/chipidea/ci13xxx_msm.c index 958069e..8d438b8 100644
> --- a/drivers/usb/chipidea/ci13xxx_msm.c
> +++ b/drivers/usb/chipidea/ci13xxx_msm.c
> @@ -55,7 +55,7 @@ static struct ci13xxx_udc_driver ci13xxx_msm_udc_driver =
> { .notify_event		= ci13xxx_msm_notify_event,
>  };
> 
> -static int ci13xxx_msm_probe(struct platform_device *pdev)
> +static int __devinit ci13xxx_msm_probe(struct platform_device *pdev)
>  {
>  	struct platform_device *plat_ci;
>  	int ret;

Best regards,
Marek Vasut
