From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 01 Feb 2014 22:30:00 +0400
Subject: [PATCH v3 3/5] ASoC: tda998x: add DT documentation of the tda998x
 CODEC
In-Reply-To: <8e4231b7a55802f58a14dd07ac5cd8b0babb1dce.1391274628.git.moinejf@free.fr>
References: <cover.1391274627.git.moinejf@free.fr>
 <8e4231b7a55802f58a14dd07ac5cd8b0babb1dce.1391274628.git.moinejf@free.fr>
Message-ID: <52ED3D28.7020709@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 01-02-2014 20:48, Jean-Francois Moine wrote:

> This patch adds the DT documentation of the NXP TDA998x CODEC.

> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
>   Documentation/devicetree/bindings/drm/i2c/tda998x.txt | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)

> diff --git a/Documentation/devicetree/bindings/drm/i2c/tda998x.txt b/Documentation/devicetree/bindings/drm/i2c/tda998x.txt
> index d7df01c..aa0d81b 100644
> --- a/Documentation/devicetree/bindings/drm/i2c/tda998x.txt
> +++ b/Documentation/devicetree/bindings/drm/i2c/tda998x.txt
[...]
> @@ -24,4 +35,10 @@ Example:
>   		interrupts = <27 2>;		/* falling edge */
>   		pinctrl-0 = <&pmx_camera>;
>   		pinctrl-names = "default";
> +			hdmi_codec: codec {

    This line is indented too far to the right.

> +			compatible = "nxp,tda998x-codec";
> +			audio-ports = <0x03>, <0x04>;
> +			audio-port-names = "i2s", "spdif";
> +			#sound-dai-cells = <1>;
> +		};
>   	};

WBR, Sergei
