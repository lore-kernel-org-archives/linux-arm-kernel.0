From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Sat, 27 Apr 2013 15:35:39 +0100
Subject: [PATCH -next] xen/arm: remove duplicated include from enlighten.c
In-Reply-To: <CAPgLHd95AtzEDXUMHryWmmVAkBfkh42hgeLKdSLFYwkO_JB-ZA@mail.gmail.com>
References: <CAPgLHd95AtzEDXUMHryWmmVAkBfkh42hgeLKdSLFYwkO_JB-ZA@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1304271535210.4180@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 27 Apr 2013, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Remove duplicated include.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Acked-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>


>  arch/arm/xen/enlighten.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> index 9a0a917..d30042e 100644
> --- a/arch/arm/xen/enlighten.c
> +++ b/arch/arm/xen/enlighten.c
> @@ -10,7 +10,6 @@
>  #include <xen/platform_pci.h>
>  #include <xen/xenbus.h>
>  #include <xen/page.h>
> -#include <xen/xen.h>
>  #include <xen/interface/sched.h>
>  #include <xen/xen-ops.h>
>  #include <asm/xen/hypervisor.h>
> 
