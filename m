From: tj@kernel.org (Tejun Heo)
Date: Tue, 24 Jun 2014 18:09:58 -0400
Subject: [PATCH 0/8] iMX6 SATA configuration
In-Reply-To: <20140624101901.GL32514@n2100.arm.linux.org.uk>
References: <20140624101901.GL32514@n2100.arm.linux.org.uk>
Message-ID: <20140624220958.GI14909@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 24, 2014 at 11:19:01AM +0100, Russell King - ARM Linux wrote:
> Another round of these patches.  I've integrated Shawn's patch to split
> the documentation into this series so I can add the DT documentation
> on top of it.
> 
>  .../devicetree/bindings/ata/ahci-platform.txt      |   6 -
>  Documentation/devicetree/bindings/ata/imx-sata.txt |  36 ++++
>  arch/arm/boot/dts/imx6q-cubox-i.dts                |   4 +
>  drivers/ata/ahci_imx.c                             | 184 ++++++++++++++++++++-
>  4 files changed, 216 insertions(+), 14 deletions(-)

Patches look good to me.  Shawn, can you please review the ahci_imx
portion?  How should the patches be routed?  Should I pick only the
ata parts or apply the whole thing?

Thanks.

-- 
tejun
