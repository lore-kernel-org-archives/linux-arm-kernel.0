From: will.deacon@arm.com (Will Deacon)
Date: Wed, 26 Jun 2013 12:32:02 +0100
Subject: [PATCH v2 0/3] Add support for ARM SMMU architectures 1 and 2
In-Reply-To: <20130626094805.GS11309@8bytes.org>
References: <1372095086-15681-1-git-send-email-will.deacon@arm.com>
 <20130626094805.GS11309@8bytes.org>
Message-ID: <20130626113202.GJ26142@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 26, 2013 at 10:48:05AM +0100, Joerg Roedel wrote:
> On Mon, Jun 24, 2013 at 06:31:23PM +0100, Will Deacon wrote:
> > Will Deacon (3):
> >   documentation: iommu: add description of ARM System MMU binding
> >   iommu: add support for ARM Ltd. System MMU architecture
> >   MAINTAINERS: add entry for ARM system MMU driver
> > 
> >  .../devicetree/bindings/iommu/arm,smmu.txt         |   70 +
> >  MAINTAINERS                                        |    6 +
> >  drivers/iommu/Kconfig                              |   13 +
> >  drivers/iommu/Makefile                             |    1 +
> >  drivers/iommu/arm-smmu.c                           | 1969 ++++++++++++++++++++
> >  5 files changed, 2059 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iommu/arm,smmu.txt
> >  create mode 100644 drivers/iommu/arm-smmu.c
> 
> Applied this series to the new arm/smmu branch, thanks Will.

Cheers Joerg! Just shout if you see any fireworks.

Will
