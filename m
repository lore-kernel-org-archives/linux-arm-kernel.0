From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 21 Jun 2013 12:25:27 +0200
Subject: [PATCHv3 09/11] pci: mvebu: add support for MSI
In-Reply-To: <1371660979-21588-10-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1371660979-21588-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1371660979-21588-10-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130621102526.GG12441@manwe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 19, 2013 at 06:56:17PM +0200, Thomas Petazzoni wrote:
> This commit adds support for Message Signaled Interrupts in the
> Marvell PCIe host controller. The work is very simple: it simply gets
> a reference to the msi_chip associated to the PCIe controller thanks
> to the msi-parent DT property, and stores this reference in the
> pci_bus structure. This is enough to let the Linux PCI core use the
> functions of msi_chip to setup and teardown MSIs.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  drivers/pci/host/pci-mvebu.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)

Reviewed-by: Thierry Reding <thierry.reding@gmail.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130621/c5330e02/attachment.sig>
