From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 10 Mar 2017 13:25:44 +0100
Subject: [PATCH v2 05/11] Documentation: DT: bindings: mfd: add A33 GPADC
 binding
In-Reply-To: <20170310103921.19469-6-quentin.schulz@free-electrons.com>
References: <20170310103921.19469-1-quentin.schulz@free-electrons.com>
 <20170310103921.19469-6-quentin.schulz@free-electrons.com>
Message-ID: <20170310122544.wkbqnzq2twfciyaw@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 10, 2017 at 11:39:15AM +0100, Quentin Schulz wrote:
> This patch adds documentation for the A33 GPADC binding.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
> 
> added in v2
> 
>  .../devicetree/bindings/mfd/sun4i-gpadc.txt        | 59 ++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> new file mode 100644
> index 0000000..17242c8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> @@ -0,0 +1,59 @@
> +Allwinner SoCs' GPADC Device Tree bindings
> +------------------------------------------
> +The Allwinner SoCs all have an ADC that can also act as a thermal sensor
> +and sometimes as a touchscreen controller.
> +
> +Required properties:
> +  - compatible: "sun8i-a33-gpadc-iio",

This doesn't match your example, and you shouldn't have IIO in
there. Compatibles shouldn't be tied to a given framework, since that
is Linux specific (and might even change in the future).

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170310/dcdb3187/attachment.sig>
