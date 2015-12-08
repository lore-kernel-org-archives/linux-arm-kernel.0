From: jeremy.linton@arm.com (Jeremy Linton)
Date: Tue, 8 Dec 2015 11:43:33 -0600
Subject: [PATCH V1 00/11] MMCONFIG refactoring and ARM64 PCI hostbridge
 init based on ACPI
In-Reply-To: <1445963922-22711-1-git-send-email-tn@semihalf.com>
References: <1445963922-22711-1-git-send-email-tn@semihalf.com>
Message-ID: <566716C5.50902@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/27/2015 11:38 AM, Tomasz Nowicki wrote:
>  From the functionality point of view this series might be split into two logic parts:
> 1. Making MMCONFIG code arch-agnostic which allows all architectures to collect
>     PCI config regions and used when necessary.
> 2. Using generic MMCONFIG code and introducing ACPI based PCI hostbridge
>     initialization for ARM64


Tested with legacy interrupts on ARM Juno R1, HP m400 (APM Potenza), and 
APM mustang. The latter two platforms have an additional pci quirk patch 
applied (to be posted shortly) to fix their problems with the config 
space accessors.

Tested-by: Jeremy Linton <jeremy.linton@arm.com>

Thanks!
