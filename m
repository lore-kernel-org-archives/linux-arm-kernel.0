From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 30 Aug 2016 16:35:32 +0530
Subject: [RESEND PATCH v3 1/3] ARM: dts: DRA7: Add "linux,pci-domain"
 property for pci dt nodes
In-Reply-To: <20160826153035.h6uyplc4mjlbc3v3@atomide.com>
References: <1470832400-11929-1-git-send-email-kishon@ti.com>
 <1470832400-11929-2-git-send-email-kishon@ti.com>
 <20160826153035.h6uyplc4mjlbc3v3@atomide.com>
Message-ID: <57C5687C.8030805@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Friday 26 August 2016 09:00 PM, Tony Lindgren wrote:
> * Kishon Vijay Abraham I <kishon@ti.com> [160810 05:34]:
>> Since DRA7 has multiple PCIe Rootcomplex, add "linux,pci-domain"
>> property to assign a PCI domain number to each of the host
>> bridges.
> 
> Is this patch safe to apply without the other changes?

Yes. I verified pcie on dra7x by applying only this patch and it doesn't break
anything.

Thanks
Kishon
