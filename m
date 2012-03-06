From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Mar 2012 22:11:52 +0000
Subject: [PATCH v5 5/7] ARM: ixp4xx: use runtime ioremap hook
In-Reply-To: <1331070317-9598-5-git-send-email-robherring2@gmail.com>
References: <alpine.LFD.2.02.1203051545200.31242@xanadu.home>
 <1331070317-9598-1-git-send-email-robherring2@gmail.com>
 <1331070317-9598-5-git-send-email-robherring2@gmail.com>
Message-ID: <20120306221152.GC15201@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 06, 2012 at 03:45:15PM -0600, Rob Herring wrote:
> diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
> index a6329a0..c60e7b8 100644
> --- a/arch/arm/mach-ixp4xx/common.c
> +++ b/arch/arm/mach-ixp4xx/common.c
> @@ -31,6 +31,7 @@
>  
>  #include <mach/udc.h>
>  #include <mach/hardware.h>
> +#include <mach/io.h>

I'll assume you have a good reason for this, inspite of there being
no mention of it in the commit log...
