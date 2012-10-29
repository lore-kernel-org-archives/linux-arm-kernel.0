From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 29 Oct 2012 11:04:26 +0100
Subject: [PATCH 2/2] MAINTAINERS: add pinctrl atmel at91 entry
In-Reply-To: <1351360392-8669-2-git-send-email-plagnioj@jcrosoft.com>
References: <1351360392-8669-1-git-send-email-plagnioj@jcrosoft.com>
 <1351360392-8669-2-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <508E54AA.1040002@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/27/2012 07:53 PM, Jean-Christophe PLAGNIOL-VILLARD :
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  MAINTAINERS |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 027ec2b..cb97031 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5624,6 +5624,12 @@ S:	Maintained
>  F:	drivers/pinctrl/
>  F:	include/linux/pinctrl/
>  
> +PIN CONTROLLER - ATMEL AT91
> +M:	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> +L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> +S:	Maintained
> +F:	drivers/pinctrl/pinctrl-at91.c
> +
>  PIN CONTROLLER - ST SPEAR
>  M:	Viresh Kumar <viresh.linux@gmail.com>
>  L:	spear-devel at list.st.com
> 


-- 
Nicolas Ferre
