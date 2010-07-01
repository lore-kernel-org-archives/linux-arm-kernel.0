From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 1 Jul 2010 10:34:13 +0800
Subject: [PATCH 06/33] Removing dead SHARPSL_LOCOMO
In-Reply-To: <b43850b1a1909496718e39687d1ca00543aa30ec.1277911346.git.siccegge@cs.fau.de>
References: <cover.1277911345.git.siccegge@cs.fau.de>
	<b43850b1a1909496718e39687d1ca00543aa30ec.1277911346.git.siccegge@cs.fau.de>
Message-ID: <AANLkTimVRdxeeQKazgFSIQJYtbmHnjDN5lUnTrVv6uoI@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 30, 2010 at 11:55 PM, Christoph Egger <siccegge@cs.fau.de> wrote:
> SHARPSL_LOCOMO doesn't exist in Kconfig, therefore removing all
> references for it from the source code.
>

A good catch, though SHARPSL_LOCOMO has be changed to SHARP_LOCOMO
later, so a better fix would be the name change only.

> Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
> ---
> ?arch/arm/mach-sa1100/include/mach/irqs.h | ? ?2 --
> ?1 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-sa1100/include/mach/irqs.h b/arch/arm/mach-sa1100/include/mach/irqs.h
> index 8c8845b..123c6c9 100644
> --- a/arch/arm/mach-sa1100/include/mach/irqs.h
> +++ b/arch/arm/mach-sa1100/include/mach/irqs.h
> @@ -77,8 +77,6 @@
> ?*/
> ?#ifdef CONFIG_SA1111
> ?#define NR_IRQS ? ? ? ? ? ? ? ? ? ? ? ?(IRQ_BOARD_END + 55)
> -#elif defined(CONFIG_SHARPSL_LOCOMO)
> -#define NR_IRQS ? ? ? ? ? ? ? ? ? ? ? ?(IRQ_BOARD_START + 4)
> ?#else
> ?#define NR_IRQS ? ? ? ? ? ? ? ? ? ? ? ?(IRQ_BOARD_START)
> ?#endif
> --
> 1.7.0.4
>
>
