From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 25 Jul 2018 15:58:39 +0200
Subject: [PATCH v2 0/7] Stop losing firmware-set DMA masks
In-Reply-To: <20180725113122.GD24736@lst.de>
References: <cover.1532382222.git.robin.murphy@arm.com>
 <20180725113122.GD24736@lst.de>
Message-ID: <CAKv+Gu_V-4ow5fF=CJG+BVLeNrcMs_e0ba3C6m-JKFwpr3O84g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 July 2018 at 13:31, Christoph Hellwig <hch@lst.de> wrote:
> Hi Robin,
>
> this series looks fine to me.  Do you want me to pull this into the
> dma-mapping tree?  I'd like to see a few more ACKs from the ACPI/OF/
> IOMMU maintainers though.
>

This fixes the issue I reported with the on-SoC NIC of the Socionext
SynQuacer, so assuming it works as advertised:

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

for the series.
