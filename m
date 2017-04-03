From: robh@kernel.org (Rob Herring)
Date: Mon, 3 Apr 2017 09:49:34 -0500
Subject: [PATCH v3 1/5] dt-bindings: update device tree binding for
 Allwinner PRCM CCUs
In-Reply-To: <20170329104246.34204-2-icenowy@aosc.io>
References: <20170329104246.34204-1-icenowy@aosc.io>
 <20170329104246.34204-2-icenowy@aosc.io>
Message-ID: <20170403144934.rnvftfuojq22aotu@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 29, 2017 at 06:42:42PM +0800, Icenowy Zheng wrote:
> From: Icenowy Zheng <icenowy@aosc.xyz>
> 
> Many Allwinner SoCs after A31 have a CCU in PRCM block.
> 
> Give the ones on H3 and A64 compatible strings.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
> Changes in v3:
> - Removed frequency info of iosc in this device tree binding document.
> Changes in v2:
> - Add iosc for R_CCU's on H3/A64.
> 
>  Documentation/devicetree/bindings/clock/sunxi-ccu.txt | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
