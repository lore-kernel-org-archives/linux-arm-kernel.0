From: khilman@ti.com (Kevin Hilman)
Date: Thu, 03 Nov 2011 07:26:57 -0700
Subject: [PATCH RESEND] ARM: OMAP: omap_device: Include linux/export.h
In-Reply-To: <1320303638.17983.5.camel@phoenix> (Axel Lin's message of "Thu,
	03 Nov 2011 15:00:38 +0800")
References: <1320303638.17983.5.camel@phoenix>
Message-ID: <87d3d9i8ni.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Axel Lin <axel.lin@gmail.com> writes:

> Include linux/export.h to fix below build warning:
>
>   CC      arch/arm/plat-omap/omap_device.o
> arch/arm/plat-omap/omap_device.c:1055: warning: data definition has no type or storage class
> arch/arm/plat-omap/omap_device.c:1055: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL'
> arch/arm/plat-omap/omap_device.c:1055: warning: parameter names (without types) in function declaration
>
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Thanks, will queue as a fix for v3.2-rc

Kevin
