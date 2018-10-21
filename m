From: sre@kernel.org (Sebastian Reichel)
Date: Sun, 21 Oct 2018 23:15:26 +0200
Subject: [PATCH v4 1/7] dt-bindings: power: supply: axp20x: add AXP813 AC
 power DT binding
In-Reply-To: <20181013080848.29894-2-oskari@lemmela.net>
References: <20181013080848.29894-1-oskari@lemmela.net>
 <20181013080848.29894-2-oskari@lemmela.net>
Message-ID: <20181021211526.gnynhk3ibte3o2kf@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Oct 13, 2018 at 11:08:42AM +0300, Oskari Lemmela wrote:
> The AXP803/AXP813 AC power supply can limit input current and voltage.
> 
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  .../devicetree/bindings/power/supply/axp20x_ac_power.txt       | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt b/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
> index 826e8a879121..7a1fb532abe5 100644
> --- a/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
> +++ b/Documentation/devicetree/bindings/power/supply/axp20x_ac_power.txt
> @@ -4,6 +4,7 @@ Required Properties:
>   - compatible: One of:
>  			"x-powers,axp202-ac-power-supply"
>  			"x-powers,axp221-ac-power-supply"
> +			"x-powers,axp813-ac-power-supply"
>  
>  This node is a subnode of the axp20x PMIC.
>  
> @@ -13,6 +14,8 @@ reading ADC channels from the AXP20X ADC.
>  The AXP22X is only able to tell if an AC power supply is present and
>  usable.
>  
> +AXP813/AXP803 are able to limit current and supply voltage
> +
>  Example:
>  
>  &axp209 {
> -- 
> 2.17.1
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181021/8640a93c/attachment.sig>
