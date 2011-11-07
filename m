From: tony@atomide.com (Tony Lindgren)
Date: Mon, 7 Nov 2011 12:35:15 -0800
Subject: [PATCH RESEND] ARM: OMAP: omap_device: Include linux/export.h
In-Reply-To: <1320303638.17983.5.camel@phoenix>
References: <1320303638.17983.5.camel@phoenix>
Message-ID: <20111107203515.GY31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Axel Lin <axel.lin@gmail.com> [111102 23:26]:
> Include linux/export.h to fix below build warning:
> 
>   CC      arch/arm/plat-omap/omap_device.o
> arch/arm/plat-omap/omap_device.c:1055: warning: data definition has no type or storage class
> arch/arm/plat-omap/omap_device.c:1055: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL'
> arch/arm/plat-omap/omap_device.c:1055: warning: parameter names (without types) in function declaration

Applying into fixes thanks.

Tony
