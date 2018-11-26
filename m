From: robh@kernel.org (Rob Herring)
Date: Mon, 26 Nov 2018 10:12:42 -0600
Subject: [PATCH v6 3/7] dt-bindings: dmaengine: xilinx_dma: add optional
 xlnx,sg-length-width property
In-Reply-To: <20181120153151.18024-3-andrea.merello@gmail.com>
References: <20181120153151.18024-1-andrea.merello@gmail.com>
 <20181120153151.18024-3-andrea.merello@gmail.com>
Message-ID: <20181126161242.GA19168@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2018 at 04:31:47PM +0100, Andrea Merello wrote:
> The width of the "length register" cannot be autodetected, and it is now
> specified with a DT property. Add documentation for it.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree at vger.kernel.org
> Cc: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> ---
> Changes in v2:
> 	- change property name
> 	- property is now optional
> 	- cc DT maintainer
> Changes in v3:
> 	- reword
> 	- cc DT maintainerS and ML
> Changes in v4:
> 	- specify the unit, the valid range and the default value
> Changes in v5:
> 	- commit message trivial fix
> 	- fix spaces before tab
> Changes in v6:
> 	None
> ---
>  Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 4 ++++
>  1 file changed, 4 insertions(+)

Please add acks/reviewed-bys when posting new versions.
