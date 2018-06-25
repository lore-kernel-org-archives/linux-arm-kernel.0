From: robh@kernel.org (Rob Herring)
Date: Mon, 25 Jun 2018 14:18:34 -0600
Subject: [PATCH v2 2/7] dt-bindings: add binding for the Allwinner A64
 DE2 bus
In-Reply-To: <20180622124540.56203-1-icenowy@aosc.io>
References: <20180622124540.56203-1-icenowy@aosc.io>
Message-ID: <20180625201834.GA14276@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 22, 2018 at 08:45:35PM +0800, Icenowy Zheng wrote:
> All the sub-blocks of Allwinner A64 DE2 needs the SRAM C on A64 SoC to
> be claimed, otherwise the whole DE2 space is inaccessible.
> 
> Add a device tree binding of the DE2 part as a sub-bus.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> No changes since v1.
> 
>  .../bindings/bus/sun50i-de2-bus.txt           | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/sun50i-de2-bus.txt

Reviewed-by: Rob Herring <robh@kernel.org>
