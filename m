From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 4 Jun 2016 09:10:21 +0100
Subject: [PATCH v2 3/7] of/irq: Break out msi-map lookup (again)
In-Reply-To: <2cbffa9a341edfd10114994f6486f6b08d0c390c.1464966939.git.robin.murphy@arm.com>
References: <cover.1464966939.git.robin.murphy@arm.com>
 <2cbffa9a341edfd10114994f6486f6b08d0c390c.1464966939.git.robin.murphy@arm.com>
Message-ID: <20160604091021.661c5508@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 3 Jun 2016 18:15:38 +0100
Robin Murphy <robin.murphy@arm.com> wrote:

> The PCI msi-map code is already doing double-duty translating IDs and
> retrieving MSI parents, which unsurprisingly is the same functionality
> we need for the identically-formatted PCI iommu-map property. Drag the
> core parsing routine up yet another layer into the general OF-PCI code,
> and further generalise it for either kind of lookup in either flavour
> of map property.
> 
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Frank Rowand <frowand.list@gmail.com>
> CC: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
