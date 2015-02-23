From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 23 Feb 2015 17:07:26 +0100
Subject: [PATCHv2 06/15] devicetree: bindings: add DT binding for the
 Marvell Armada 39x SoC family
In-Reply-To: <1424451874-25375-7-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1424451874-25375-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1424451874-25375-7-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <54EB503E.5010502@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 20/02/2015 18:04, Thomas Petazzoni wrote:
> The Marvell Armada 39x is a family of two SoCs: the Armada 390 and the
> Armada 398, with a slightly different number of interfaces. This
> commit introduces the Device Tree binding that documents the top-level
> compatible strings for Armada 39x based platforms.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


Thanks,

Gregory

> ---
>  Documentation/devicetree/bindings/arm/armada-39x.txt | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/armada-39x.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/armada-39x.txt b/Documentation/devicetree/bindings/arm/armada-39x.txt
> new file mode 100644
> index 0000000..53d4ff9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/armada-39x.txt
> @@ -0,0 +1,20 @@
> +Marvell Armada 39x Platforms Device Tree Bindings
> +-------------------------------------------------
> +
> +Boards with a SoC of the Marvell Armada 39x family shall have the
> +following property:
> +
> +Required root node property:
> +
> + - compatible: must contain "marvell,armada390"
> +
> +In addition, boards using the Marvell Armada 398 SoC shall have the
> +following property before the previous one:
> +
> +Required root node property:
> +
> +compatible: must contain "marvell,armada398"
> +
> +Example:
> +
> +compatible = "marvell,a398-db", "marvell,armada398", "marvell,armada390";
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
