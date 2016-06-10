From: robh@kernel.org (Rob Herring)
Date: Fri, 10 Jun 2016 12:42:19 -0500
Subject: [PATCH V2 3/5] Documentation/devicetree/bindings: b850v3_lvds_dp
In-Reply-To: <59c49951b95b0eb5b34eede6cfce526e72bc2443.1465486875.git.peter.senna@collabora.com>
References: <cover.1465486875.git.peter.senna@collabora.com>
 <59c49951b95b0eb5b34eede6cfce526e72bc2443.1465486875.git.peter.senna@collabora.com>
Message-ID: <20160610174219.GA22375@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 09, 2016 at 06:25:03PM +0200, Peter Senna Tschudin wrote:
> Devicetree bindings documentation for the GE B850v3 LVDS/DP++
> display bridge.
> 
> Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Signed-off-by: Peter Senna Tschudin <peter.senna@collabora.com>
> ---
> Changes from V1:
>  - Replaced '_' by '-' in node names or compatible strings
>  - Added missing @73 to the example
> 
>  .../devicetree/bindings/ge/b850v3_lvds_dp.txt      | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ge/b850v3_lvds_dp.txt

Acked-by: Rob Herring <robh@kernel.org>
