From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Mar 2017 12:06:16 +0000
Subject: [PATCHv2 14/14] treewide: Decouple cacheflush.h and set_memory.h
In-Reply-To: <1488413706-9739-15-git-send-email-labbott@redhat.com>
References: <1488413706-9739-1-git-send-email-labbott@redhat.com>
 <1488413706-9739-15-git-send-email-labbott@redhat.com>
Message-ID: <20170302120616.GK21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 01, 2017 at 04:15:06PM -0800, Laura Abbott wrote:
> diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
> index 1cb9d11..d69bebf 100644
> --- a/arch/arm/include/asm/cacheflush.h
> +++ b/arch/arm/include/asm/cacheflush.h
> @@ -16,7 +16,6 @@
>  #include <asm/shmparam.h>
>  #include <asm/cachetype.h>
>  #include <asm/outercache.h>
> -#include <asm/set_memory.h>
>  
>  #define CACHE_COLOUR(vaddr)	((vaddr & (SHMLBA - 1)) >> PAGE_SHIFT)
>  

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
