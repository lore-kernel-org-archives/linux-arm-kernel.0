From: will.deacon@arm.com (Will Deacon)
Date: Fri, 2 Aug 2013 13:01:15 +0100
Subject: [Ksummit-2013-discuss] [ARM ATTEND] Describing complex,
 non-probable system topologies
In-Reply-To: <CAErSpo7yUDMsaVSR6kcy4Jeb0naVpPPfpzFZQ2MP0NLDH1aAFg@mail.gmail.com>
References: <20130801183531.GB29831@mudshark.cambridge.arm.com>
 <CAErSpo7yUDMsaVSR6kcy4Jeb0naVpPPfpzFZQ2MP0NLDH1aAFg@mail.gmail.com>
Message-ID: <20130802120115.GO2465@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 01, 2013 at 11:26:30PM +0100, Bjorn Helgaas wrote:
> On Thu, Aug 1, 2013 at 12:35 PM, Will Deacon <will.deacon@arm.com> wrote:
> 
> > ... For example, interfacing
> > a PCIe device with an SMMU requires knowledge of both the requester id
> > associated with the device and how that maps to incoming stream ids
> > (based off the AXI bus id) on the SMMU.
> 
> Tangent: We're trying to hash out a way for IOMMU drivers to use a PCI
> interface to discover the requester IDs associated with a device.  We
> currently only have one users (intel-iommu.c), and it would be awesome
> to have another user to help make things generic.  Please chime in if
> you have opinions.
> 
> https://lkml.kernel.org/r/20130711210326.1701.56478.stgit at bling.home

Ooh, yes, thanks Bjorn. I'll find some time to take a look at that.

Cheers,

Will
