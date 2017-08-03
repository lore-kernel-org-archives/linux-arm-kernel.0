From: will.deacon@arm.com (Will Deacon)
Date: Thu, 3 Aug 2017 16:16:48 +0100
Subject: [PATCH v3 0/5] ACPI: DMA ranges management
In-Reply-To: <20170803123239.11359-1-lorenzo.pieralisi@arm.com>
References: <20170803123239.11359-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170803151647.GA20783@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 03, 2017 at 01:32:34PM +0100, Lorenzo Pieralisi wrote:
> This patch series is v3 of a previous posting:
> 
> v2->v3:
> 	- Fixed DMA masks computation
>         - Fixed size computation overflow in acpi_dma_get_range()
> 
> v1->v2:
> 	- Reworked acpi_dma_get_range() flow and logs
> 	- Added IORT named component address limits
> 	- Renamed acpi_dev_get_resources() helper function
> 	- Rebased against v4.13-rc3
> 
> v2: http://lkml.kernel.org/r/20170731152323.32488-1-lorenzo.pieralisi at arm.com
> v1: http://lkml.kernel.org/r/20170720144517.32529-1-lorenzo.pieralisi at arm.com

For the arm64 bits:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
