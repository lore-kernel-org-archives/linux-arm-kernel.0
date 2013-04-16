From: andrew.murray@arm.com (Andrew Murray)
Date: Tue, 16 Apr 2013 12:49:03 +0100
Subject: [PATCH v6 1/3] of/pci: Unify pci_process_bridge_OF_ranges from
 Microblaze and PowerPC
In-Reply-To: <516C2FEF.7080006@monstr.eu>
References: <1365693969-23907-1-git-send-email-Andrew.Murray@arm.com>
 <1365693969-23907-2-git-send-email-Andrew.Murray@arm.com>
 <20130415145741.4e4c362b@skate> <516C2FEF.7080006@monstr.eu>
Message-ID: <20130416114903.GA13259@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 15, 2013 at 05:50:55PM +0100, Michal Simek wrote:
> That's why please add this header to this patch.
> 
> diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
> index 3e428a1..f30887e 100644
> --- a/drivers/of/of_pci.c
> +++ b/drivers/of/of_pci.c
> @@ -1,6 +1,7 @@
>  #include <linux/kernel.h>
>  #include <linux/export.h>
>  #include <linux/of.h>
> +#include <linux/of_address.h>
>  #include <linux/of_pci.h>
>  #include <asm/prom.h>
> 
> 
> When you fix it:
> Acked-by: Michal Simek <monstr@monstr.eu>

I've added this fix to the latest patchset (v7) and also your Ack - thanks for
your feedback (and the robot...).

Andrew Murray
