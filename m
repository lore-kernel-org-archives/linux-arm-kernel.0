From: robh@kernel.org (Rob Herring)
Date: Wed, 22 Feb 2017 15:25:28 -0600
Subject: [PATCH v3 01/18] dt-bindings: power: battery: add
 constant-charge-current property
In-Reply-To: <20170214094112.27426-2-quentin.schulz@free-electrons.com>
References: <20170214094112.27426-1-quentin.schulz@free-electrons.com>
 <20170214094112.27426-2-quentin.schulz@free-electrons.com>
Message-ID: <20170222212528.vo7fbayactwfzgao@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 14, 2017 at 10:40:55AM +0100, Quentin Schulz wrote:
> This adds the constant-charge-current property to the list of optional
> properties of the battery.
> 
> The constant charge current is critical for batteries as they can't
> handle all charge currents.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
> 
> added in v3
> 
>  Documentation/devicetree/bindings/power/supply/battery.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
> index d78a4aa..3e830fe 100644
> --- a/Documentation/devicetree/bindings/power/supply/battery.txt
> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
> @@ -7,6 +7,7 @@ Optional Properties:
>   - voltage-min-design-microvolt: drained battery voltage
>   - energy-full-design-microwatt-hours: battery design energy
>   - charge-full-design-microamp-hours: battery design capacity
> + - constant-charge-current-microamp: battery constant charge current

Kind of long, though so are the others. Maybe just 
"constant-charge-microamp" as uA implies current.

Otherwise,

Acked-by: Rob Herring <robh@kernel.org>
