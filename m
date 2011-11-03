From: khilman@ti.com (Kevin Hilman)
Date: Thu, 03 Nov 2011 10:48:44 -0700
Subject: [PATCH RESEND] ARM: OMAP: omap_device: Include linux/export.h
In-Reply-To: <4EB2A987.2040805@windriver.com> (Paul Gortmaker's message of
	"Thu, 3 Nov 2011 10:47:35 -0400")
References: <1320303638.17983.5.camel@phoenix> <87d3d9i8ni.fsf@ti.com>
	<4EB2A987.2040805@windriver.com>
Message-ID: <877h3hhzb7.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul Gortmaker <paul.gortmaker@windriver.com> writes:

> On 11-11-03 10:26 AM, Kevin Hilman wrote:
>> Axel Lin <axel.lin@gmail.com> writes:
>> 
>>> Include linux/export.h to fix below build warning:
>>>
>>>   CC      arch/arm/plat-omap/omap_device.o
>>> arch/arm/plat-omap/omap_device.c:1055: warning: data definition has no type or storage class
>>> arch/arm/plat-omap/omap_device.c:1055: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL'
>>> arch/arm/plat-omap/omap_device.c:1055: warning: parameter names (without types) in function declaration
>>>
>>> Signed-off-by: Axel Lin <axel.lin@gmail.com>
>> 
>> Thanks, will queue as a fix for v3.2-rc
>
> It is probably better if I track this, since export.h won't
> exist until Linus pulls the module.h-split tree, and I'm
> guessing that will be closer to the end of the merge window.

OK, sounds good.  Feel free to add:

Acked-by: Kevin Hilman <khilman@ti.com>

Thanks,

Kevin
