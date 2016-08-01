From: robh@kernel.org (Rob Herring)
Date: Mon, 1 Aug 2016 11:59:23 -0500
Subject: [PATCH V3 3/5] Documentation/devicetree/bindings: b850v3_lvds_dp
In-Reply-To: <cd3180af2c0f35b4a36624124f4d564cd1f35dec.1469993472.git.peter.senna@collabora.com>
References: <cover.1469993472.git.peter.senna@collabora.com>
 <cd3180af2c0f35b4a36624124f4d564cd1f35dec.1469993472.git.peter.senna@collabora.com>
Message-ID: <20160801165923.GA5529@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 31, 2016 at 09:55:36PM +0200, Peter Senna Tschudin wrote:
> Devicetree bindings documentation for the GE B850v3 LVDS/DP++
> display bridge.
> 
> Cc: Javier Martinez Canillas <javier@dowhile0.org>
> Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Signed-off-by: Peter Senna Tschudin <peter.senna@collabora.com>
> ---
> Unchanged from V2.
> 
> Changes from V1:
>  - Replaced '_' by '-' in node names or compatible strings
>  - Added missing @73 to the example
> 
>  .../devicetree/bindings/ge/b850v3-lvds-dp.txt      | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ge/b850v3-lvds-dp.txt

Acked-by: Rob Herring <robh@kernel.org>
