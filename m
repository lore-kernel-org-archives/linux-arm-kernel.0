From: enrico.scholz@sigma-chemnitz.de (Enrico Scholz)
Date: Thu, 23 Dec 2010 13:26:03 +0100
Subject: [PATCH 2/23]  Alternative mmc structure to support pxa168, pxa910,
	mmp2 family SD
References: <661A407B-8073-4B51-AE40-E3BA6D0B5C42@marvell.com>
Message-ID: <lyei98vfok.fsf@ensc-virt.intern.sigma-chemnitz.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Philip Rakity <prakity@marvell.com> writes:

> --- a/arch/arm/mach-mmp/include/mach/regs-apmu.h
> +++ b/arch/arm/mach-mmp/include/mach/regs-apmu.h
> +#define APMU_SDH2	APMU_REG(0x0e8)
> +#define APMU_SDH3	APMU_REG(0x0ec)

is this really correct?  "ARMADA 16x Application Processor Family"
(October 2010) manual says that these registers are at 0xe0 + 0xe4.


Enrico
