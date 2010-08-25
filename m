From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Wed, 25 Aug 2010 15:29:34 +0300
Subject: [PATCH v2 6/8] arm: allow passing an ELF64 header to
	elf_check_arch()
In-Reply-To: <AANLkTim761FFWZoyL1hJmAA6ArROB4KukXTEX+yh4VNY@mail.gmail.com>
References: <cover.1273041357.git.ext-mika.1.westerberg@nokia.com>
	<3c8da055f0a84cfd1c6659d9fda24e4eb97ab9fb.1273041358.git.ext-mika.1.westerberg@nokia.com>
	<20100510112036.GC14337@n2100.arm.linux.org.uk>
	<20100510120920.GD11783@esdhcp04058.research.nokia.com>
	<20100510122156.GA7796@n2100.arm.linux.org.uk>
	<20100716081405.GR4247@esdhcp04058.research.nokia.com>
	<AANLkTim761FFWZoyL1hJmAA6ArROB4KukXTEX+yh4VNY@mail.gmail.com>
Message-ID: <20100825122934.GL15307@esdhcp04058.research.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Aug 25, 2010 at 04:40:45AM +0200, ext Lei Wen wrote:
> 
> I have tried your patch, and it works perfect.
> But there is something  inconvenient  that I have to modify the
> PHYS_OFFSET and mach/Makefile.boot
> manually if I want to get a kdump capable kernel.

Yeah, it's a bit annoying. I remember that I had some plans to make it
configurable but never implemented it.

> How about add additional configuration like CONFIG_RELOCATABLE
> CONFIG_PHYSICAL_STARTas x86?
> This would do great help for formal usage.

You are right, something like that is eventually needed. I'll try to find some
time to look into that and cook up some solution.

Thanks,
MW
