From: bhelgaas@google.com (Bjorn Helgaas)
Date: Thu, 1 Aug 2013 16:26:30 -0600
Subject: [Ksummit-2013-discuss] [ARM ATTEND] Describing complex,
 non-probable system topologies
In-Reply-To: <20130801183531.GB29831@mudshark.cambridge.arm.com>
References: <20130801183531.GB29831@mudshark.cambridge.arm.com>
Message-ID: <CAErSpo7yUDMsaVSR6kcy4Jeb0naVpPPfpzFZQ2MP0NLDH1aAFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 1, 2013 at 12:35 PM, Will Deacon <will.deacon@arm.com> wrote:

> ... For example, interfacing
> a PCIe device with an SMMU requires knowledge of both the requester id
> associated with the device and how that maps to incoming stream ids
> (based off the AXI bus id) on the SMMU.

Tangent: We're trying to hash out a way for IOMMU drivers to use a PCI
interface to discover the requester IDs associated with a device.  We
currently only have one users (intel-iommu.c), and it would be awesome
to have another user to help make things generic.  Please chime in if
you have opinions.

https://lkml.kernel.org/r/20130711210326.1701.56478.stgit at bling.home
