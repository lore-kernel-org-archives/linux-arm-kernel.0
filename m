From: robh@kernel.org (Rob Herring)
Date: Mon, 10 Sep 2018 13:19:13 -0500
Subject: [PATCH v5 3/7] dt-bindings: dmaengine: xilinx_dma: add optional
 xlnx,sg-length-width property
In-Reply-To: <20180907062502.8241-3-andrea.merello@gmail.com>
References: <20180907062502.8241-1-andrea.merello@gmail.com>
 <20180907062502.8241-3-andrea.merello@gmail.com>
Message-ID: <20180910181913.GA13764@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri,  7 Sep 2018 08:24:58 +0200, Andrea Merello wrote:
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
> ---
>  Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
