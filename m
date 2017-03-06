From: Jean-Philippe.Brucker@arm.com (Jean-Philippe Brucker)
Date: Mon, 6 Mar 2017 11:31:08 +0000
Subject: [RFC PATCH 18/30] PCI: Make "PRG Response PASID Required"
 handling common
In-Reply-To: <20170303211140.GC31767@bhelgaas-glaptop.roam.corp.google.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-19-jean-philippe.brucker@arm.com>
 <20170303211140.GC31767@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <20170306113108.GC28804@e106794-lin.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 03, 2017 at 03:11:40PM -0600, Bjorn Helgaas wrote:
> On Mon, Feb 27, 2017 at 07:54:29PM +0000, Jean-Philippe Brucker wrote:
> > The PASID ECN to the PCIe spec added a bit in the PRI status register that
> > allows a Function to declare whether a PRG Response should contain the
> > PASID prefix or not.
> > 
> > Move the helper that accesses it from amd_iommu into the PCI subsystem,
> > renaming it to something more consistent with the spec, and introducing
> > another obscure acronym to make it all fit.
> 
> Maybe mention the acronym itelf and spell it out here?

Sure, I'll add this.

Thanks,
Jean-Philippe
