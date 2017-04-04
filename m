From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 4 Apr 2017 17:43:04 +0200
Subject: [PATCH v3 4/4] ARM: dts: sun7i: Add can0_pins_a pinctrl settings
In-Reply-To: <1491238814-4888-5-git-send-email-menschel.p@posteo.de>
References: <1491238814-4888-1-git-send-email-menschel.p@posteo.de>
 <1491238814-4888-5-git-send-email-menschel.p@posteo.de>
Message-ID: <20170404154304.7vgqx3jbkfm3n5lt@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 03, 2017 at 07:00:14PM +0200, Patrick Menschel wrote:
> The A20 SoC has an on-board CAN controller. This patch adds
> the pinctrl settings for pins PH20 and PH21.
> 
> This patch is adapted from the description in
> Documentation/devicetree/bindings/net/can/sun4i_can.txt
> 
> Signed-off-by: Patrick Menschel <menschel.p@posteo.de>
> ---
>  arch/arm/boot/dts/sun7i-a20.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> index c637e10..8536caf 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -1096,6 +1096,11 @@
>  			#interrupt-cells = <3>;
>  			#gpio-cells = <3>;
>  
> +			can0_pins_a: can0 at 0 {
> +				pins = "PH20","PH21";

Same thing here, you need a space after that comma. I've fixed it and
applied the patch.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170404/7bf638a5/attachment.sig>
