From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 20 Jun 2014 11:49:05 -0300
Subject: [PATCH v2 2/2] ARM: mvebu: Use system controller to get the soc
 id when possible
In-Reply-To: <1403274953-21790-3-git-send-email-gregory.clement@free-electrons.com>
References: <1403274953-21790-1-git-send-email-gregory.clement@free-electrons.com>
 <1403274953-21790-3-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140620144905.GA26861@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 Jun 04:35 PM, Gregory CLEMENT wrote:
> diff --git a/arch/arm/mach-mvebu/mvebu-soc-id.c b/arch/arm/mach-mvebu/mvebu-soc-id.c
> index 12c66cac967d..922b1380b0be 100644
> --- a/arch/arm/mach-mvebu/mvebu-soc-id.c
> +++ b/arch/arm/mach-mvebu/mvebu-soc-id.c
> @@ -25,8 +25,10 @@
>  #include <linux/of_address.h>
>  #include <linux/slab.h>
>  #include <linux/sys_soc.h>
> +#include "common.h"
>  #include "mvebu-soc-id.h"
>  
> +

Spurious whitespace?

>  #define PCIE_DEV_ID_OFF		0x0
>  #define PCIE_DEV_REV_OFF	0x8
>  
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
