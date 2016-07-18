From: robh+dt@kernel.org (Rob Herring)
Date: Mon, 18 Jul 2016 12:54:21 -0500
Subject: [PATCH v4 3/8] of/irq: Break out msi-map lookup (again)
In-Reply-To: <cb0040f52022b049a3515f0b01a81a83381ad7d9.1467388950.git.robin.murphy@arm.com>
References: <cover.1467388950.git.robin.murphy@arm.com>
 <cb0040f52022b049a3515f0b01a81a83381ad7d9.1467388950.git.robin.murphy@arm.com>
Message-ID: <CAL_Jsq+BJVeeAJcvvLRjhjuovVCw6taNxssbG9raN8UWTXfrYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 1, 2016 at 11:50 AM, Robin Murphy <robin.murphy@arm.com> wrote:
> The PCI msi-map code is already doing double-duty translating IDs and
> retrieving MSI parents, which unsurprisingly is the same functionality
> we need for the identically-formatted PCI iommu-map property. Drag the
> core parsing routine up yet another layer into the general OF-PCI code,
> and further generalise it for either kind of lookup in either flavour
> of map property.
>
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Frank Rowand <frowand.list@gmail.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

I've only skimmed thru it, but looks fine to me:

Acked-by: Rob Herring <robh@kernel.org>
