From: robh@kernel.org (Rob Herring)
Date: Tue, 25 Sep 2018 04:25:00 -0700
Subject: [RFC PATCH 11/40] dt-bindings: PCI: keystone: Add bindings to get
 device control module
In-Reply-To: <20180921102155.22839-12-kishon@ti.com>
References: <20180921102155.22839-1-kishon@ti.com>
 <20180921102155.22839-12-kishon@ti.com>
Message-ID: <5baa1b0c.1c69fb81.efde0.46e9@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 21 Sep 2018 15:51:26 +0530, Kishon Vijay Abraham I wrote:
> Add bindings to get device control module which has the device id and
> vendor id to be configured in the keystone PCIe controller.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  Documentation/devicetree/bindings/pci/pci-keystone.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
