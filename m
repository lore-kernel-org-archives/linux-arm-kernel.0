From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 7 Aug 2012 09:21:35 +0000
Subject: [PATCH 1/1] ARM: kirkwood: fix typo in Makefile.boot
In-Reply-To: <1344177932-6466-1-git-send-email-sebastian.hesselbarth@googlemail.com>
References: <1344177932-6466-1-git-send-email-sebastian.hesselbarth@googlemail.com>
Message-ID: <201208070921.35459.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 05 August 2012, Sebastian Hesselbarth wrote:
> Just a small typo fix to make lsxl dtbs compile
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  arch/arm/mach-kirkwood/Makefile.boot |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-kirkwood/Makefile.boot b/arch/arm/mach-kirkwood/Makefile.boot
> index 2a576ab..a571755 100644
> --- a/arch/arm/mach-kirkwood/Makefile.boot
> +++ b/arch/arm/mach-kirkwood/Makefile.boot
> @@ -9,5 +9,5 @@ dtb-$(CONFIG_MACH_ICONNECT_DT) += kirkwood-iconnect.dtb
>  dtb-$(CONFIG_MACH_IB62X0_DT) += kirkwood-ib62x0.dtb
>  dtb-$(CONFIG_MACH_TS219_DT)	+= kirkwood-qnap-ts219.dtb
>  dtb-$(CONFIG_MACH_GOFLEXNET_DT) += kirkwood-goflexnet.dtb
> -dbt-$(CONFIG_MACH_LSXL_DT) += kirkwood-lschlv2.dtb
> -dbt-$(CONFIG_MACH_LSXL_DT) += kirkwood-lsxhl.dtb
> +dtb-$(CONFIG_MACH_LSXL_DT) += kirkwood-lschlv2.dtb
> +dtb-$(CONFIG_MACH_LSXL_DT) += kirkwood-lsxhl.dtb

As Jason and Andrew are both currently unavailable, I'm applying this directly
to the fixes branch in arm-soc.

	Arnd
