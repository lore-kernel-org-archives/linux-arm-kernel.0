From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 20 Apr 2017 16:31:57 +0200
Subject: [PATCH V11 00/11] IOMMU probe deferral support
In-Reply-To: <1491823266-1209-1-git-send-email-sricharan@codeaurora.org>
References: <1491823266-1209-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <20170420143157.GG7266@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 10, 2017 at 04:50:55PM +0530, Sricharan R wrote:
>  arch/arm64/mm/dma-mapping.c       | 142 +++++---------------------------------
>  drivers/acpi/arm64/iort.c         |  48 ++++++++++++-
>  drivers/acpi/glue.c               |   5 --
>  drivers/acpi/scan.c               |  11 ++-
>  drivers/base/dd.c                 |   9 +++
>  drivers/base/dma-mapping.c        |  41 +++++++++++
>  drivers/iommu/arm-smmu-v3.c       |  46 +-----------
>  drivers/iommu/arm-smmu.c          | 110 +++++++++++++----------------
>  drivers/iommu/of_iommu.c          | 126 ++++++++++++++++++++++++---------
>  drivers/of/device.c               |  23 +++++-
>  drivers/of/platform.c             |  10 +--
>  drivers/pci/probe.c               |  28 --------
>  include/acpi/acpi_bus.h           |   2 +-
>  include/asm-generic/vmlinux.lds.h |   1 -
>  include/linux/acpi.h              |   7 +-
>  include/linux/acpi_iort.h         |   3 -
>  include/linux/dma-mapping.h       |  12 ++++
>  include/linux/of_device.h         |  10 ++-
>  18 files changed, 312 insertions(+), 322 deletions(-)

Applied, thanks.
