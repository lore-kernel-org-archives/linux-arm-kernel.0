From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 4 Apr 2017 17:40:55 +0200
Subject: [PATCH v3 2/4] ARM: dts: sun4i: Add can0_pins_a pinctrl settings
In-Reply-To: <1491238814-4888-3-git-send-email-menschel.p@posteo.de>
References: <1491238814-4888-1-git-send-email-menschel.p@posteo.de>
 <1491238814-4888-3-git-send-email-menschel.p@posteo.de>
Message-ID: <20170404154055.ccteyn3eeviciwvh@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 03, 2017 at 07:00:12PM +0200, Patrick Menschel wrote:
> The A10 SoC has an on-board CAN controller. This patch adds the
> pinctrl settings for pins PH20 and PH21.
> 
> This patch is adapted from the description in
> Documentation/devicetree/bindings/net/can/sun4i_can.txt
> 
> Signed-off-by: Patrick Menschel <menschel.p@posteo.de>
> ---
>  arch/arm/boot/dts/sun4i-a10.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
> index 7c559e7..f7dced4 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -974,6 +974,11 @@
>  			#interrupt-cells = <3>;
>  			#gpio-cells = <3>;
>  
> +			can0_pins_a: can0 at 0 {
> +				pins = "PH20","PH21";

You need a space after the comma here. Fixed and applied.
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170404/773f44d3/attachment.sig>
