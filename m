From: robh@kernel.org (Rob Herring)
Date: Thu, 10 Aug 2017 13:25:47 -0500
Subject: [PATCH 1/2] devicetree: ARM: zynq: Add DT binding for eFuse
 controller
In-Reply-To: <4b4bfaad88f16d7229bf3da58be8f50f9d82a461.1501842586.git.michal.simek@xilinx.com>
References: <4b4bfaad88f16d7229bf3da58be8f50f9d82a461.1501842586.git.michal.simek@xilinx.com>
Message-ID: <20170810182547.7c6qtfikzekfq7pq@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 04, 2017 at 12:29:53PM +0200, Michal Simek wrote:
> Add DT binding for eFuse controller available at Xilinx Zynq
> SoC.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Acked-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>
> ---
> 
>  Documentation/devicetree/bindings/arm/zynq/zynq-efuse.txt | 15 +++++++++++++++

Move to bindings/nvmem with the other efuse bindings.

With that,

Acked-by: Rob Herring <robh@kernel.org>

>  1 file changed, 15 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/zynq/zynq-efuse.txt
