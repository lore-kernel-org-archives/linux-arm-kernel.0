From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 22 Jul 2016 14:53:33 +0530
Subject: [PATCH 2/2] ARM: DRA7: select PCI_DOMAINS config
In-Reply-To: <5791D8C7.5020303@ti.com>
References: <1469102276-14777-1-git-send-email-kishon@ti.com>
 <1469102276-14777-3-git-send-email-kishon@ti.com>
 <8047226.VhgpLo8JQu@wuerfel> <20160722071644.GZ28140@atomide.com>
 <5791D8C7.5020303@ti.com>
Message-ID: <5791E615.3070904@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 22 July 2016 01:56 PM, Kishon Vijay Abraham I wrote:

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 90542db..0cccb50 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -338,6 +338,7 @@ config ARCH_MULTIPLATFORM
>         select MULTI_IRQ_HANDLER
>         select SPARSE_IRQ
>         select USE_OF
> +       select PCI_DOMAINS if PCI

Keep the select list in sorted order.

Regards,
Sekhar
