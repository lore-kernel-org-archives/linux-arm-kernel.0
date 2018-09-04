From: robh@kernel.org (Rob Herring)
Date: Mon, 3 Sep 2018 19:34:50 -0500
Subject: [PATCH 4/7] dt-bindings: display/rockchip: dw_hdmi: Add property
 for HDMI frequency list
In-Reply-To: <20180828185513.13216-5-urjaman@gmail.com>
References: <20180828185513.13216-1-urjaman@gmail.com>
 <20180828185513.13216-5-urjaman@gmail.com>
Message-ID: <5b8e8a5b.1c69fb81.2c8b4.3fde@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2018 at 06:55:10PM +0000, Urja Rannikko wrote:
> Signed-off-by: Urja Rannikko <urjaman@gmail.com>
> ---
>  .../devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt    | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt b/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt
> index adc94fc3c9f8..edeacbbc4f26 100644
> --- a/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt
> +++ b/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt
> @@ -34,6 +34,7 @@ Optional properties
>  - clock-names: May contain "cec" as defined in dw_hdmi.txt.
>  - clock-names: May contain "grf", power for grf io.
>  - clock-names: May contain "vpll", external clock for some hdmi phy.
> +- rockchip,hdmi-rates-hz: List of allowed HDMI frequencies in Hz.

Can't you use assigned clocks properties for this purpose?

Though maybe I don't understand the purpose. I don't recall any other 
HDMI (or LVDS, DP, etc.) binding needing something like this. So why do 
you need it?

Rob
