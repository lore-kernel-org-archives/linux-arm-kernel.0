From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 21 Jun 2013 09:20:54 +0200
Subject: [PATCHv3 04/11] of: pci: add registry of MSI chips
In-Reply-To: <1371660979-21588-5-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1371660979-21588-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1371660979-21588-5-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130621092054.4c3cb717@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant,

On Wed, 19 Jun 2013 18:56:12 +0200, Thomas Petazzoni wrote:
> This commit adds a very basic registry of msi_chip structures, so that
> an IRQ controller driver can register an msi_chip, and a PCIe host
> controller can find it, based on a 'struct device_node'.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  drivers/of/of_pci.c    | 22 ++++++++++++++++++++++
>  include/linux/msi.h    |  2 ++
>  include/linux/of_pci.h |  4 ++++
>  3 files changed, 28 insertions(+)

Any comments about this idea? It is quite fundamental for this patch,
which requires a way of connecting PCI busses (handled by a PCI
driver) and a msi_chip (handled by an IRQ controller driver).

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
