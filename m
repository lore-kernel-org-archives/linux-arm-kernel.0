From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Jul 2014 09:22:36 +0100
Subject: linux-next: manual merge of the mvebu tree with the arm tree
In-Reply-To: <20140707112853.7f5a9323@canb.auug.org.au>
References: <20140707112853.7f5a9323@canb.auug.org.au>
Message-ID: <20140707082236.GX21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 07, 2014 at 11:28:53AM +1000, Stephen Rothwell wrote:
> diff --cc arch/arm/mach-mvebu/headsmp-a9.S
> index 7c91ddb6f1f7,da5bb292b91c..000000000000
> --- a/arch/arm/mach-mvebu/headsmp-a9.S
> +++ b/arch/arm/mach-mvebu/headsmp-a9.S
> @@@ -14,8 -14,9 +14,10 @@@
>   
>   #include <linux/linkage.h>
>   #include <linux/init.h>
>  +#include <asm/assembler.h>
>   
> + #include <asm/assembler.h>
> + 

Obviously not quite correct - this looks like an automatic merge, something
that will have to be kept an eye on during the proper merge window.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
