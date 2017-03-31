From: robh@kernel.org (Rob Herring)
Date: Fri, 31 Mar 2017 14:07:34 -0500
Subject: [PATCH v5 16/24] dt-bindings: PCI: dra7xx: Add dt bindings to
 enable unaligned access
In-Reply-To: <20170327094520.3129-17-kishon@ti.com>
References: <20170327094520.3129-1-kishon@ti.com>
 <20170327094520.3129-17-kishon@ti.com>
Message-ID: <20170331190734.n6wnd3rm73o4be5z@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 27, 2017 at 03:15:12PM +0530, Kishon Vijay Abraham I wrote:
> Update device tree binding documentation of TI's dra7xx PCI
> controller to include property for enabling unaligned mem access.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  Documentation/devicetree/bindings/pci/ti-pci.txt | 5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
