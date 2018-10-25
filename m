From: robh@kernel.org (Rob Herring)
Date: Thu, 25 Oct 2018 14:15:08 -0500
Subject: [PATCH 2/3] dt-bindings: nvmem: Add bindings for ZynqMP nvmem
 driver
In-Reply-To: <20181020083603.27602-3-nava.manne@xilinx.com>
References: <20181020083603.27602-1-nava.manne@xilinx.com>
 <20181020083603.27602-3-nava.manne@xilinx.com>
Message-ID: <20181025191508.GA26613@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 20, 2018 at 02:06:02PM +0530, Nava kishore Manne wrote:
> Add documentation to describe Xilinx ZynqMP nvmem driver
> bindings.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v1:
> 		Created a Seperate(New) DT binding file as
> 		suggested by Rob.
> 
> Changes for RFC-V3:
>                 -None.
> 
> Changes for RFC-V2:
>                 -Moved nvmem_firmware node as a child to
>                  firwmare node.
> 
>  .../bindings/nvmem/xlnx,zynqmp-nvmem.txt           | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.txt

Before I okay any ZynqMP firmware related bindings, I want to see a 
complete binding, not things added one by one.

Rob
