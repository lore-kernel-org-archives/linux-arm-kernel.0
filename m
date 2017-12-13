From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 13 Dec 2017 16:50:00 +0100
Subject: [PATCH v4 1/4] dt-bindings: pwm: binding allwinner sun8i
 R40/V40/T3.
In-Reply-To: <20171213144309.GA18167@arx-s1>
References: <20171213144309.GA18167@arx-s1>
Message-ID: <20171213155000.5qrykowmsawhy3sx@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Dec 13, 2017 at 10:43:09PM +0800, hao_zhang wrote:
> This patch adds allwinner R40, V40, T3 pwm binding documents.
> 
> Signed-off-by: hao_zhang <hao5781286@gmail.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-sun8i.txt | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt b/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
> new file mode 100644
> index 0000000..76750d8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
> @@ -0,0 +1,18 @@
> +Allwinner sun8i R40/V40/T3 SoC PWM controller
> +
> +Required properties:
> +- compatible: should be one of:
> +- "allwinner,sun8i-r40-pwm"

Please indent that part.

Once fixed,
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171213/9a73189c/attachment.sig>
