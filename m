From: tn@semihalf.com (Tomasz Nowicki)
Date: Thu, 15 Oct 2015 20:51:17 +0200
Subject: [PATCH 05/11] x86, pci, acpi: Move arch-agnostic MMCONFIG (aka
 ECAM) and ACPI code out of arch/x86/ directory
In-Reply-To: <561FD3BB.70501@arm.com>
References: <20150604102253.GA31773@red-moon> <5570447D.3020705@linaro.org>
 <557504A2.3060203@linaro.org> <20150608151443.GA16151@red-moon>
 <55E4340D.6050004@linaro.org> <55ED6010.3020406@linaro.org>
 <20150908150727.GF29293@red-moon> <55F0388B.1090607@linaro.org>
 <20150911112018.GA13033@red-moon> <55F6DFF6.4010807@linaro.org>
 <20151015132200.GA7621@red-moon> <561FB985.8070509@linaro.org>
 <561FD3BB.70501@arm.com>
Message-ID: <561FF5A5.1040305@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/15/2015 06:26 PM, Marc Zyngier wrote:
> On 15/10/15 15:34, Tomasz Nowicki wrote:
>
>> Of course your help in testing is welcomed. Also please have a look at
>> my GICv3/ITS patches, they are important for ACPI PCI.
>
> Where is the dependency? ACPI/PCI should really be standalone.
>
There are no dependencies in code. Just wanted to say that ARM64 
machines with GICv3/ITS and PCI on board need both series to use MSI 
with ACPI kernel. Sorry for confusion.

Regards,
Tomasz
