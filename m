From: robh@kernel.org (Rob Herring)
Date: Thu, 17 Aug 2017 10:10:22 -0500
Subject: [PATCH 1/4] dt-bindings: add binding for Allwinner A64 SRAM
 controller and SRAM C
In-Reply-To: <20170809085627.32687-2-icenowy@aosc.io>
References: <20170809085627.32687-1-icenowy@aosc.io>
 <20170809085627.32687-2-icenowy@aosc.io>
Message-ID: <20170817151022.a2agd5xv2ctpup3b@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 09, 2017 at 04:56:24PM +0800, Icenowy Zheng wrote:
> The display engine on Allwinner A64 wants to claim the SRAM C section.
> 
> Add a SRAM controller compatible for A64, and a SRAM section compatible
> for its SRAM C.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  Documentation/devicetree/bindings/sram/sunxi-sram.txt | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
