From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Fri, 07 Sep 2018 13:11:27 +0900
Subject: [PATCH 2/2] pci: dwc: add UniPhier PCIe host controller support
In-Reply-To: <20180906140926.GB214747@bhelgaas-glaptop.roam.corp.google.com>
References: <20180906103819.252A.4A936039@socionext.com>
 <20180906140926.GB214747@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <20180907131126.FACD.4A936039@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

On Thu, 6 Sep 2018 09:09:27 -0500 <helgaas@kernel.org> wrote:

> On Thu, Sep 06, 2018 at 10:38:20AM +0900, Kunihiko Hayashi wrote:
> > > > +++ b/drivers/pci/controller/dwc/pcie-uniphier.c
> > > > @@ -0,0 +1,464 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +//
> > > > +// PCI-express host controller driver for UniPhier SoCs
> > > > +// Copyright 2018 Socionext Inc.
> > > > +// Author: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > > 
> > > Use /* ... */ comments except for the SPDX line.
> > 
> > Okay, although I wondered which way to put, I'll replace the header next.
> 
> The easiest thing is to look at similar files already in the tree and
> follow their style.  The details are here:
> 
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst#n540
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/license-rules.rst#n74

Thanks for your advice.
Although I've found both styles in some sub-systems, these are helpful for me.

I replaced it in posted v2.

Thank you,

---
Best Regards,
Kunihiko Hayashi
