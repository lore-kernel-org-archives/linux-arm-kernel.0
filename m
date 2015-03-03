From: bhelgaas@google.com (Bjorn Helgaas)
Date: Mon, 2 Mar 2015 21:43:48 -0600
Subject: [PATCH - v7] of: Move of_dma_configure() to device.c to help
 re-use
In-Reply-To: <1425333548-8802-1-git-send-email-m-karicheri2@ti.com>
References: <1425333548-8802-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <CAErSpo7MsxgVZyhpijRzVN7mVNcbN7M4A4W-UKaNs4AnmGrB6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 2, 2015 at 3:59 PM, Murali Karicheri <m-karicheri2@ti.com> wrote:
> Move of_dma_configure() to device.c so it can be re-used for PCI devices to
> obtain DMA configuration from DT.  Also add a second argument so that for
> PCI, the DT node of root bus host bridge can be used to obtain the DMA
> configuration for the slave PCI device.
>
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com> (AMD Seattle)
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Will Deacon <will.deacon@arm.com>
> CC: Joerg Roedel <joro@8bytes.org>
> CC: Grant Likely <grant.likely@linaro.org>
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Russell King <linux@arm.linux.org.uk>
> CC: Arnd Bergmann <arnd@arndb.de>
> ---
>  - Based on the existing patch applied to arm-pci/pci/iommu for pci next (Bjorn)
>  - Fixed the build issue reported on ARCH=x86_64

Hi Murali,

Can you please repost the entire series with fixed patches?  It's
easier for me to reapply the whole thing at once than it is to keep
track of and fiddle with individual patches.

Bjorn
