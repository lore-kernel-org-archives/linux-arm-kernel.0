From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 15 Dec 2010 07:20:32 +0800
Subject: [PATCH] ARM: pxa: PXA_ESERIES depends on FB_W100.
In-Reply-To: <20101214180505.GL15575@mail.wantstofly.org>
References: <20101214180505.GL15575@mail.wantstofly.org>
Message-ID: <AANLkTikkvCbBO-6vaQen+cg3Fx1Fhz+1N2EfJh_hsQo0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 15, 2010 at 2:05 AM, Lennert Buytenhek
<buytenh@wantstofly.org> wrote:
> As arch/arm/mach-pxa/eseries.c references w100fb_gpio_{read,write}()
> directly.
>
> Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>

Applied to 'fix'.

>
> diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
> index dd235ec..c93e73d 100644
> --- a/arch/arm/mach-pxa/Kconfig
> +++ b/arch/arm/mach-pxa/Kconfig
> @@ -540,6 +540,7 @@ config MACH_ICONTROL
> ?config ARCH_PXA_ESERIES
> ? ? ? ?bool "PXA based Toshiba e-series PDAs"
> ? ? ? ?select PXA25x
> + ? ? ? select FB_W100
>
> ?config MACH_E330
> ? ? ? ?bool "Toshiba e330"
>
