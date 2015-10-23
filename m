From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 Oct 2015 22:28:27 +0200
Subject: [PATCH v4 05/12] doc/bindings: Update Layerscape PCIe devicetree
 bindings for LS2080A
In-Reply-To: <1445628721-10483-6-git-send-email-bhupesh.sharma@freescale.com>
References: <1445628721-10483-1-git-send-email-bhupesh.sharma@freescale.com>
 <1445628721-10483-6-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <4784400.64dhyokllJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 24 October 2015 01:01:54 Bhupesh Sharma wrote:
> Update the definition of the Layerscape PCI compatible string to add
> support for LS2080A, as the controller on LS2080A is different from
> LS1021A SoC.
> 
> While at it, move the clock related properties in the Designware PCIe
> controller bindings to 'optional' set of properties.
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
> ---
>  .../devicetree/bindings/pci/designware-pcie.txt    |   10 +++++-----
>  .../devicetree/bindings/pci/layerscape-pci.txt     |   14 ++++++++++++--
>  2 files changed, 17 insertions(+), 7 deletions(-)
> 

This one depends on a patch that is in Bjorn's PCI tree but not
yet in mainline.

Please add my 'Acked-by: Arnd Bergmann <arnd@arndb.de>' and submit it to
Bjorn so he can apply the patch on top of the other one.

	Arnd
