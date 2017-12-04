From: robh@kernel.org (Rob Herring)
Date: Mon, 4 Dec 2017 15:40:07 -0600
Subject: [PATCH 2/4] dt-bindings: PCI: dra7xx: Add bindings for unaligned
 access in host mode
In-Reply-To: <20171201061311.16691-3-vigneshr@ti.com>
References: <20171201061311.16691-1-vigneshr@ti.com>
 <20171201061311.16691-3-vigneshr@ti.com>
Message-ID: <20171204214007.xyjvy2kfacjonjza@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 01, 2017 at 11:43:09AM +0530, Vignesh R wrote:
> Update device tree binding documentation of TI's dra7xx PCI controller
> for enabling unaligned mem access as applicable not just in EP mode but
> in host mode as well.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  Documentation/devicetree/bindings/pci/ti-pci.txt | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
