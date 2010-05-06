From: fabioestevam@yahoo.com (Fabio Estevam)
Date: Thu, 6 May 2010 11:33:15 -0700 (PDT)
Subject: [PATCHv1 2.6.34-rc6 1/3] mxc: gadget: remove 60mhz clock
	requirement for freescale mx51 usb core
In-Reply-To: <1273100171-3235-2-git-send-email-Dinh.Nguyen@freescale.com>
Message-ID: <501887.6368.qm@web51006.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



--- On Wed, 5/5/10, Dinh Nguyen <Dinh.Nguyen@freescale.com> wrote:

> From: Dinh Nguyen <Dinh.Nguyen@freescale.com>
> Subject: [PATCHv1 2.6.34-rc6 1/3] mxc: gadget: remove 60mhz clock requirement for freescale mx51 usb core
> To: linux-kernel at vger.kernel.org
> Cc: amit.kucheria at canonical.com, "Dinh Nguyen" <Dinh.Nguyen@freescale.com>, s.hauer at pengutronix.de, linux-usb at vger.kernel.org, Jun.Li at freescale.com, grant.likely at secretlab.ca, linux-arm-kernel at lists.infradead.org, daniel at caiaq.de, bryan.wu at canonical.com, xiao-lizhang at freescale.com, valentin.longchamp at epfl.ch
> Date: Wednesday, May 5, 2010, 7:56 PM
> for mx51, usb core is clocked from
> sources that are not 60mhz.
> 
> Signed-off-by: Dinh Nguyen <Dinh.Nguyen@freescale.com>
> ---
>  drivers/usb/gadget/fsl_mx3_udc.c |???14
> ++++++++------
>  1 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/gadget/fsl_mx3_udc.c
> b/drivers/usb/gadget/fsl_mx3_udc.c
> index 20a802e..d0b8bde 100644
> --- a/drivers/usb/gadget/fsl_mx3_udc.c
> +++ b/drivers/usb/gadget/fsl_mx3_udc.c

Shouldn't this file be renamed to fsl_mx_udc.c ?

fsl_mx3_udc.c suggests that it applies for MX31/MX35 processors.

Regards,

Fabio Estevam


      
