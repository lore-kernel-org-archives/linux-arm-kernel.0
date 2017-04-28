From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Apr 2017 14:14:48 +0200
Subject: [RFC/RFT PATCH 02/18] PCI: Add pci_free_host_bridge interface
In-Reply-To: <20170426111809.19922-3-lorenzo.pieralisi@arm.com>
References: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
 <20170426111809.19922-3-lorenzo.pieralisi@arm.com>
Message-ID: <CAK8P3a14i6mAxH1NpniEncyoo1Hc0YSGdM_vvBjCHQoVdX0n+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 26, 2017 at 1:17 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> Commit a52d1443bba1 ("PCI: Export host bridge registration interface")
> exported the pci_alloc_host_bridge() interface so that PCI host
> controllers drivers can make use of it.
>
> Introduce pci_alloc_host_bridge() kernel counterpart to free the
> host bridge data structures, pci_free_host_bridge(), export it
> and update kernel functions releasing host bridge objects allocated
> memory to make use of it.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
