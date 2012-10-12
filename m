From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Fri, 12 Oct 2012 09:17:53 +0000
Subject: [RFC PATCH v2 08/16] ARM: omap: add hsmmc am33xx specific init
In-Reply-To: <1349982281-10785-9-git-send-email-mporter@ti.com>
References: <1349982281-10785-1-git-send-email-mporter@ti.com>
 <1349982281-10785-9-git-send-email-mporter@ti.com>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EAA6374@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Matt

On Fri, Oct 12, 2012 at 00:34:33, Porter, Matt wrote:
> AM33xx requires special handling in hsmmc initialization
> platform glue.

Since AM335x boots mainly through DT, do we still need this patch.
This function will be called in case of initializing hsmmc with
Platform data. 

> 
> Signed-off-by: Matt Porter <mporter@ti.com>
> ---
>  arch/arm/mach-omap2/hsmmc.c |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 

..snip..
..snip..

>  	name = "omap_hsmmc";
>  	res = snprintf(oh_name, MAX_OMAP_MMC_HWMOD_NAME_LEN,
> -- 
> 1.7.9.5
> 
> _______________________________________________
> Davinci-linux-open-source mailing list
> Davinci-linux-open-source at linux.davincidsp.com
> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
> 


Regards, 
Gururaja
