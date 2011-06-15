From: hpa@zytor.com (H. Peter Anvin)
Date: Tue, 14 Jun 2011 21:31:27 -0700
Subject: [RFC,PATCH] Cleanup PC parallel port Kconfig
In-Reply-To: <987664A83D2D224EAE907B061CE93D5301E7281306@orsmsx505.amr.corp.intel.com>
References: <20110614190850.GA13526@linux-mips.org>
	<987664A83D2D224EAE907B061CE93D5301E7281306@orsmsx505.amr.corp.intel.com>
Message-ID: <4DF8359F.10809@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/14/2011 03:08 PM, Luck, Tony wrote:
> diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
> index 38280ef..849805a 100644
> --- a/arch/ia64/Kconfig
> +++ b/arch/ia64/Kconfig
> @@ -23,6 +23,7 @@ config IA64
>  	select HAVE_ARCH_TRACEHOOK
>  	select HAVE_DMA_API_DEBUG
>  	select HAVE_GENERIC_HARDIRQS
> +	select HAVE_PC_PARPORT
>  	select GENERIC_IRQ_PROBE
>  	select GENERIC_PENDING_IRQ if SMP
>  	select IRQ_PER_CPU
> 
> I took a look at the back of all my ia64 systems - none of them
> have a parallel port.  It seems unlikely that new systems will
> start adding parallel ports :-)
> 
> So even if I had a printer (or other device) that used a parallel
> port, I have no way to test it.
> 

If it has PCI slots, it can have a parallel port.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
