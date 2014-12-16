From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Dec 2014 09:57:36 +0100
Subject: [RFC/PATCH 1/4 PATCH] ARM: mvebu: use dt_fixup to provide
 fallback for enable-method
In-Reply-To: <548F971B.1040108@alliedtelesis.co.nz>
References: <5488A2C0.5040804@alliedtelesis.co.nz>
 <548F408E.3080302@alliedtelesis.co.nz> <548F971B.1040108@alliedtelesis.co.nz>
Message-ID: <3835642.IqTezlTZup@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 December 2014 02:21:16 Chris Packham wrote:
> 
> Well I've sent something up to the devicetree/LKML so we'll see where
> that goes.

Ok, thanks!

> Another alternative I that is not without precedence is to add a
> of_fdt_xxx function (like of_fdt_limit_memory) to drivers/of/fdt.c
> which already uses a custom CFLAGS.

Agreed, that would work too.

	Arnd
