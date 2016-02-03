From: robh@kernel.org (Rob Herring)
Date: Wed, 3 Feb 2016 14:23:00 -0600
Subject: [PATCH v2 08/12] devicetree: bindings: add DT binding for the
 Marvell Armada 3700 SoC family
In-Reply-To: <1454524889-9207-9-git-send-email-gregory.clement@free-electrons.com>
References: <1454524889-9207-1-git-send-email-gregory.clement@free-electrons.com>
 <1454524889-9207-9-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <CAL_JsqJ8tY-XNo7LcP82LB5ywK_41fQzDqcyFOca2MXhu+Gw2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 3, 2016 at 12:41 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> The Marvell Armada 3700 is a family of ARMv8 CA53 SoCs. This commit
> introduces the Device Tree binding that documents the top-level
> compatible strings for Armada 3700 based platforms.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  .../devicetree/bindings/arm/marvell/armada-37xx.txt      | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
>
> diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
> new file mode 100644
> index 000000000000..17e90e8b5f76
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
> @@ -0,0 +1,16 @@
> +Marvell Armada 37xx Platforms Device Tree Bindings
> +--------------------------------------------------
> +
> +Boards using a SoC of the Marvell Armada 37xx family must carry the
> +following root node property:
> +
> + - compatible: must contain "marvell,armada3710"
> +
> +In addition, boards using the Marvell Armada 3720 SoC shall have the
> +following property before the previous one:
> +
> + - compatible: must contain "marvell,armada3720"
> +
> +Example:
> +
> +compatible = "marvell,armada-3720-db", "marvell,armada3710", "marvell,armada3720";

The order is wrong?
