From: robh@kernel.org (Rob Herring)
Date: Fri, 3 Mar 2017 00:21:22 -0600
Subject: [PATCH V2 1/4] dt-bindings: display:
 megachips-stdpxxxx-ge-b850v3-fw
In-Reply-To: <85c405428279c1c8e062d825112db800342a98ca.1488287639.git.peter.senna@collabora.com>
References: <cover.1488287639.git.peter.senna@collabora.com>
 <85c405428279c1c8e062d825112db800342a98ca.1488287639.git.peter.senna@collabora.com>
Message-ID: <20170303062122.qa2jwrfwh6kqp77m@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 28, 2017 at 03:28:10PM +0100, Peter Senna Tschudin wrote:
> Devicetree binding documentation for the second video output
> of the GE B850v3:
>    STDP4028-ge-b850v3-fw bridges (LVDS-DP)
>    STDP2690-ge-b850v3-fw bridges (DP-DP++)
> 
> Added entry for MegaChips at:
>  Documentation/devicetree/bindings/vendor-prefixes.txt
> 
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Martyn Welch <martyn.welch@collabora.co.uk>
> Cc: Martin Donnelly <martin.donnelly@ge.com>
> Cc: Javier Martinez Canillas <javier@dowhile0.org>
> Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Signed-off-by: Peter Senna Tschudin <peter.senna@collabora.com>
> ---
> Changes from V1:
>  - New subject
>  - Moved binding documentation from bindings/video/ to bindings/display/bridge/
>  - Reworded to describe hardware instead of the driver
>  - Reformated the bindings to have one set of required properties per device
>  - Updated reg description
>  - Defined number of ports and what they are for
> 
>  .../bridge/megachips-stdpxxxx-ge-b850v3-fw.txt     | 94 ++++++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.txt        |  1 +
>  2 files changed, 95 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/megachips-stdpxxxx-ge-b850v3-fw.txt

Acked-by: Rob Herring <robh@kernel.org>
