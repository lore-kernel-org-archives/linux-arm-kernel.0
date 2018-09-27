From: robh@kernel.org (Rob Herring)
Date: Thu, 27 Sep 2018 14:21:04 -0500
Subject: [RFC PATCH v3 2/3] dt-bindings: fpga: Add bindings for ZynqMP
 nvmem driver
In-Reply-To: <20180922134149.5693-3-nava.manne@xilinx.com>
References: <20180922134149.5693-1-nava.manne@xilinx.com>
 <20180922134149.5693-3-nava.manne@xilinx.com>
Message-ID: <20180927192104.GA7898@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 22, 2018 at 07:11:48PM +0530, Nava kishore Manne wrote:
> Add documentation to describe Xilinx ZynqMP nvmem driver
> bindings.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v3:
> 		-None.
> Changes for v2:
>                 -Moved nvmem_firmware node as a child to
>                  firwmare node.
> 
>  .../firmware/xilinx/xlnx,zynqmp-firmware.txt  | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)

There are various components of the zynqmp firmware bindings being sent 
separately. I cannot review it piece by piece. So please the firmware 
bindings as a complete set. Really, I mainly need to see a complete 
example.

Rob
