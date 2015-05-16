From: Suravee.Suthikulpanit@amd.com (Suthikulpanit, Suravee)
Date: Sat, 16 May 2015 15:14:36 +0000
Subject: [V4 PATCH 3/6] pci: Generic function for setting up PCI device
 DMA coherency
In-Reply-To: <CAErSpo7NkeXvtFH7jDNeYm6HTZO_G=r77EuJ8vOL4WUKSpQxAQ@mail.gmail.com>
Message-ID: <D17CC88E.1AFDA%suravee.suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

On 5/16/15, 07:41, "Bjorn Helgaas" <bhelgaas@google.com> wrote:

>On Fri, May 15, 2015 at 4:23 PM, Suravee Suthikulpanit
><Suravee.Suthikulpanit@amd.com> wrote:
>> This patch refactors of_pci_dma_configure() into a more generic
>> pci_dma_configure(), which can be reused by non-OF code.
>> Then, it adds support for setting up PCI device DMA coherency from
>> ACPI _CCA object that should normally be specified in the DSDT node
>> of its PCI host bridge..
>
>From the changelog, it sounds like you might be able to split this
>into two patches:
>
>1) Refactor of_pci_dma_configure(), with no functional change
>2) Add support for using _CCA
>
>If that's possible, please do so to make this easier to review.
>
>Bjorn

Yes, I can separate the patch out. This would mainly affect ACPI+PCI
support for ARM64 (which is in progress).

Thanks,

Surafvee
