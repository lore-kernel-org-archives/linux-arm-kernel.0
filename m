From: robherring2@gmail.com (Rob Herring)
Date: Wed, 31 Oct 2012 21:04:24 -0500
Subject: [PATCH] arm-dt: Enable DT proc updates.
In-Reply-To: <1351699069-4661-1-git-send-email-panto@antoniou-consulting.com>
References: <1351699069-4661-1-git-send-email-panto@antoniou-consulting.com>
Message-ID: <5091D8A8.9010307@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/31/2012 10:57 AM, Pantelis Antoniou wrote:
> This simple patch enables dynamic changes of the DT tree on runtime
> to be visible to the device-tree proc interface.
> 
> Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>

Acked-by: Rob Herring <rob.herring@calxeda.com>

> ---
>  arch/arm/include/asm/prom.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/include/asm/prom.h b/arch/arm/include/asm/prom.h
> index aeae9c6..6d65ba2 100644
> --- a/arch/arm/include/asm/prom.h
> +++ b/arch/arm/include/asm/prom.h
> @@ -11,6 +11,8 @@
>  #ifndef __ASMARM_PROM_H
>  #define __ASMARM_PROM_H
>  
> +#define HAVE_ARCH_DEVTREE_FIXUPS
> +
>  #ifdef CONFIG_OF
>  
>  extern struct machine_desc *setup_machine_fdt(unsigned int dt_phys);
> 
