From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Thu, 06 Sep 2018 10:38:20 +0900
Subject: [PATCH 2/2] pci: dwc: add UniPhier PCIe host controller support
In-Reply-To: <20180905172529.GO107892@bhelgaas-glaptop.roam.corp.google.com>
References: <1536114731-28630-3-git-send-email-hayashi.kunihiko@socionext.com>
 <20180905172529.GO107892@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <20180906103819.252A.4A936039@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

On Wed, 5 Sep 2018 12:25:29 -0500 <helgaas@kernel.org> wrote:

> Follow capitalization conventions for subject.
> 
> On Wed, Sep 05, 2018 at 11:32:11AM +0900, Kunihiko Hayashi wrote:
> > This introduces specific glue layer for UniPhier platform to support
> > PCIe host controller that is based on the Designware PCIe Core, and
> > this driver supports Root Complex (host) mode.
> 
> s/Designware/DesignWare/
> s/Core/core/

I'll fix them like [1/2].

> 
> > diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
> > new file mode 100644
> > index 0000000..13ce02e
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pcie-uniphier.c
> > @@ -0,0 +1,464 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +//
> > +// PCI-express host controller driver for UniPhier SoCs
> > +// Copyright 2018 Socionext Inc.
> > +// Author: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> 
> Use /* ... */ comments except for the SPDX line.

Okay, although I wondered which way to put, I'll replace the header next.

Thank you,

---
Best Regards,
Kunihiko Hayashi
