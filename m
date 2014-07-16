From: tony.luck@intel.com (Luck, Tony)
Date: Wed, 16 Jul 2014 23:46:32 +0000
Subject: [PATCH v2 1/3] ACPI: ARM64 does not have a BIOS add config for
 BIOS table scan.
In-Reply-To: <53C70CCC.2080109@zytor.com>
References: <1404898746-6685-1-git-send-email-hanjun.guo@linaro.org>
 <1404898746-6685-2-git-send-email-hanjun.guo@linaro.org>
 <53C70CCC.2080109@zytor.com>
Message-ID: <3908561D78D1C84285E8C5FCA982C28F3285FB3C@ORSMSX114.amr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +	select ACPI_LEGACY_TABLES_LOOKUP if ACPI

> This shouldn't actually be set on IA64, should it?  IA64 doesn't have
> BIOS, either, it has EFI/UEFI, like ARM64...

Which ACPI tables are in the "LEGACY" category affected by this option?

-Tony
