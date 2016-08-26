From: tony@atomide.com (Tony Lindgren)
Date: Fri, 26 Aug 2016 08:30:35 -0700
Subject: [RESEND PATCH v3 1/3] ARM: dts: DRA7: Add "linux,pci-domain"
 property for pci dt nodes
In-Reply-To: <1470832400-11929-2-git-send-email-kishon@ti.com>
References: <1470832400-11929-1-git-send-email-kishon@ti.com>
 <1470832400-11929-2-git-send-email-kishon@ti.com>
Message-ID: <20160826153035.h6uyplc4mjlbc3v3@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kishon Vijay Abraham I <kishon@ti.com> [160810 05:34]:
> Since DRA7 has multiple PCIe Rootcomplex, add "linux,pci-domain"
> property to assign a PCI domain number to each of the host
> bridges.

Is this patch safe to apply without the other changes?

Regards,

Tony
