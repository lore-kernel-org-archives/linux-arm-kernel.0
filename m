From: robherring2@gmail.com (Rob Herring)
Date: Tue, 24 Jun 2014 07:45:03 -0500
Subject: [PATCH 0/8] iMX6 SATA configuration
In-Reply-To: <20140624101901.GL32514@n2100.arm.linux.org.uk>
References: <20140624101901.GL32514@n2100.arm.linux.org.uk>
Message-ID: <CAL_JsqLvcRmOfjhuoyND_n7DGSNWPDCJT8iDQs-SfJrYjZj5zQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 24, 2014 at 5:19 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Another round of these patches.  I've integrated Shawn's patch to split
> the documentation into this series so I can add the DT documentation
> on top of it.
>
>  .../devicetree/bindings/ata/ahci-platform.txt      |   6 -
>  Documentation/devicetree/bindings/ata/imx-sata.txt |  36 ++++
>  arch/arm/boot/dts/imx6q-cubox-i.dts                |   4 +
>  drivers/ata/ahci_imx.c                             | 184 ++++++++++++++++++++-
>  4 files changed, 216 insertions(+), 14 deletions(-)

For patches 1, 4, and 6:

Acked-by: Rob Herring <robh@kernel.org>

Rob
