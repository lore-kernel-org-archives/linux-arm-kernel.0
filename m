From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 16 Jan 2013 11:38:34 +0000
Subject: [PATCH v2 2/9] ARM: PRIMA2: enable AUTO_ZRELADDR for SIRF in
 Kconfig
In-Reply-To: <1358315610-25001-2-git-send-email-Barry.Song@csr.com>
References: <1358315610-25001-1-git-send-email-Barry.Song@csr.com>
 <1358315610-25001-2-git-send-email-Barry.Song@csr.com>
Message-ID: <20130116113834.GC10218@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 16, 2013 at 05:53:28AM +0000, Barry Song wrote:
> From: Barry Song <Baohua.Song@csr.com>
> 
> prima2 and marco have different memory base address. prima2
> begins from 0 and marco begins from

Runaway commit message.

> 
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
>  arch/arm/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index f95ba14..13f89a2 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -394,6 +394,7 @@ config ARCH_GEMINI
>  config ARCH_SIRF
>  	bool "CSR SiRF"
>  	select ARCH_REQUIRE_GPIOLIB
> +	select AUTO_ZRELADDR
>  	select COMMON_CLK
>  	select GENERIC_CLOCKEVENTS
>  	select GENERIC_IRQ_CHIP
> -- 
> 1.7.5.4
> 
> 
> 
> Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
> More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

Thanks,
Mark.
