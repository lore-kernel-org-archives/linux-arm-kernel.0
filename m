From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 02 Jun 2016 14:49:01 +0200
Subject: [PATCH 3/5] Documentation/devicetree/bindings: Add b850v3_lvds_dp
In-Reply-To: <1464626385-19253-4-git-send-email-peter.senna@collabora.com>
References: <1464626385-19253-1-git-send-email-peter.senna@collabora.com>
 <1464626385-19253-4-git-send-email-peter.senna@collabora.com>
Message-ID: <1464871741.3307.16.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

Am Montag, den 30.05.2016, 18:39 +0200 schrieb Peter Senna Tschudin:
> Devicetree bindings documentation for the GE B850v3 LVDS/DP++
> display bridge.
> 
> Signed-off-by: Peter Senna Tschudin <peter.senna@collabora.com>
> ---
>  .../devicetree/bindings/ge/b850v3_lvds_dp.txt      | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ge/b850v3_lvds_dp.txt
> 
> diff --git a/Documentation/devicetree/bindings/ge/b850v3_lvds_dp.txt b/Documentation/devicetree/bindings/ge/b850v3_lvds_dp.txt
> new file mode 100644
> index 0000000..32e123a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ge/b850v3_lvds_dp.txt
> @@ -0,0 +1,38 @@
> +Driver for GE B850v3 LVDS/DP++ display bridge
> +
> +Required properties:
> +  - compatible : should be "ge,b850v3_lvds_dp".

In the cover mail you write that this is a combination of the STDP4028
DP transmitter and STDP2690 DP/DP++ converter. So shouldn't this binding
comprise two device tree nodes, one with compatible "st,stdp4028", one
with "st,stdp2690", then?
Is the stdp2690 connected to the stdp4028's i2c master?

regards
Philipp
