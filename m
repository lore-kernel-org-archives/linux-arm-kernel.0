From: will.deacon@arm.com (Will Deacon)
Date: Fri, 9 Mar 2018 13:48:24 +0000
Subject: [GIT PULL] ACPI IORT updates for v4.17
In-Reply-To: <20180308115425.GA31267@e107981-ln.cambridge.arm.com>
References: <20180308115425.GA31267@e107981-ln.cambridge.arm.com>
Message-ID: <20180309134823.GF15537@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 08, 2018 at 11:54:25AM +0000, Lorenzo Pieralisi wrote:
> Jia He (1):
>       ACPI/IORT: Remove linker section for IORT entries again
> 
> Lorenzo Pieralisi (2):
>       ACPI/IORT: Remove temporary iort_get_id_mapping_index() ACPICA guard
>       ACPI/IORT: Remove obsolete ACPI_IORT_SMMU_V3_CAVIUM_CN99XX define
> 
>  drivers/acpi/arm64/iort.c         | 12 ------------
>  include/asm-generic/vmlinux.lds.h |  1 -
>  2 files changed, 13 deletions(-)

Nice diffstat! ;)

I'll pull this into for-next/core.

Will
