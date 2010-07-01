From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 1 Jul 2010 22:40:51 +0800
Subject: [PATCH 06/33] Removing dead SHARPSL_LOCOMO
In-Reply-To: <20100701132351.GB32541@faui48a.informatik.uni-erlangen.de>
References: <cover.1277911345.git.siccegge@cs.fau.de>
	<b43850b1a1909496718e39687d1ca00543aa30ec.1277911346.git.siccegge@cs.fau.de>
	<AANLkTimVRdxeeQKazgFSIQJYtbmHnjDN5lUnTrVv6uoI@mail.gmail.com>
	<20100701132351.GB32541@faui48a.informatik.uni-erlangen.de>
Message-ID: <AANLkTilxNz_iEWKtgvLHjce6PTN_G-7bt2jxeLbIXxVa@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 1, 2010 at 9:23 PM, Christoph Egger <siccegge@cs.fau.de> wrote:
> On Thu, Jul 01, 2010 at 10:34:13AM +0800, Eric Miao wrote:
>> On Wed, Jun 30, 2010 at 11:55 PM, Christoph Egger <siccegge@cs.fau.de> wrote:
>> > SHARPSL_LOCOMO doesn't exist in Kconfig, therefore removing all
>> > references for it from the source code.
>> >
>>
>> A good catch, though SHARPSL_LOCOMO has be changed to SHARP_LOCOMO
>> later, so a better fix would be the name change only.
>
> Hi! Updated patch below
>
> ----
> From: Christoph Egger <siccegge@cs.fau.de>
> Date: Wed, 30 Jun 2010 12:36:20 +0200
> Subject: [PATCH 06/33] Replacing dead SHARPSL_LOCOMO with SHARP_LOCOMO
>
> SHARP_LOCOMO doesn't exist in Kconfig, therefore replacing all
> references for it with SHARP_LOCOMO in the source code.
>
> Signed-off-by: Christoph Egger <siccegge@cs.fau.de>

Acked-by: Eric Miao <eric.y.miao@gmail.com>

> ---
> ?arch/arm/mach-sa1100/include/mach/irqs.h | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-sa1100/include/mach/irqs.h b/arch/arm/mach-sa1100/include/mach/irqs.h
> index 8c8845b..d18f21a 100644
> --- a/arch/arm/mach-sa1100/include/mach/irqs.h
> +++ b/arch/arm/mach-sa1100/include/mach/irqs.h
> @@ -77,7 +77,7 @@
> ?*/
> ?#ifdef CONFIG_SA1111
> ?#define NR_IRQS ? ? ? ? ? ? ? ? ? ? ? ?(IRQ_BOARD_END + 55)
> -#elif defined(CONFIG_SHARPSL_LOCOMO)
> +#elif defined(CONFIG_SHARP_LOCOMO)
> ?#define NR_IRQS ? ? ? ? ? ? ? ? ? ? ? ?(IRQ_BOARD_START + 4)
> ?#else
> ?#define NR_IRQS ? ? ? ? ? ? ? ? ? ? ? ?(IRQ_BOARD_START)
> --
> 1.7.0.4
>
>
>
