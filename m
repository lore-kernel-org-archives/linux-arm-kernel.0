From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 17 May 2018 18:05:24 +0100
Subject: [PATCH v9 00/12] Support PPTT for ARM64
In-Reply-To: <20180511235807.30834-1-jeremy.linton@arm.com>
References: <20180511235807.30834-1-jeremy.linton@arm.com>
Message-ID: <20180517170523.h7tuvbzdfluuidcz@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2018 at 06:57:55PM -0500, Jeremy Linton wrote:
> Jeremy Linton (12):
>   drivers: base: cacheinfo: move cache_setup_of_node()
>   drivers: base: cacheinfo: setup DT cache properties early
>   cacheinfo: rename of_node to fw_token
>   arm64/acpi: Create arch specific cpu to acpi id helper
>   ACPI/PPTT: Add Processor Properties Topology Table parsing
>   ACPI: Enable PPTT support on ARM64
>   drivers: base cacheinfo: Add support for ACPI based firmware tables
>   arm64: Add support for ACPI based firmware tables
>   arm64: topology: rename cluster_id
>   arm64: topology: enable ACPI/PPTT based CPU topology
>   ACPI: Add PPTT to injectable table list
>   arm64: topology: divorce MC scheduling domain from core_siblings

Queued for 4.18 (without Sudeep's latest property_read_u64 cacheinfo
patch - http://lkml.kernel.org/r/20180517154701.GA20281 at e107155-lin; I
can add it separately).

Thanks.

-- 
Catalin
