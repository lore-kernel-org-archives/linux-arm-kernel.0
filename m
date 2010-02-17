From: jassisinghbrar@gmail.com (jassi brar)
Date: Wed, 17 Feb 2010 14:50:28 +0900
Subject: PL-330 DMA driver
Message-ID: <1b68c6791002162150wb8fbae8ya1e5b3c0a56b7fad@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

  Many Samsung SoCs have PL-330 as the DMA controller and the driver
is missing in the mainline.

A few months ago, Joonyoung Shim of Samsung, attempted the driver for PL-330
based on the DMA API(drivers/dma/), but the patches weren't accepted.
Perhaps the driver should go into arch/arm/common/ ? Or inconspicuously
into arch/arm/plat-s3cxxxx/ ?

Could maintainers please suggest what is the best place for the PL330
controller driver?

Regards
