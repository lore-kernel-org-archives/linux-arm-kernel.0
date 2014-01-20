From: olof@lixom.net (Olof Johansson)
Date: Sun, 19 Jan 2014 20:06:09 -0800
Subject: [PATCH v3 16/24] drm/i2c: tda998x: add DT documentation
In-Reply-To: <20140119195844.0c975b90@armhf>
References: <cover.1390153344.git.moinejf@free.fr>
 <20140119195844.0c975b90@armhf>
Message-ID: <CAOesGMi96wkHM8jfHNVnM7RJyW2vVoP6FT4YyYzKp-kfc0jTuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Jan 19, 2014 at 10:58 AM, Jean-Francois Moine <moinejf@free.fr> wrote:
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
>  .../devicetree/bindings/drm/i2c/tda998x.txt        | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/drm/i2c/tda998x.txt

Please cc bindings for review to devicetree at vger.kernel.org (cc:d here now)

> diff --git a/Documentation/devicetree/bindings/drm/i2c/tda998x.txt b/Documentation/devicetree/bindings/drm/i2c/tda998x.txt
> new file mode 100644
> index 0000000..72da71d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/drm/i2c/tda998x.txt
> @@ -0,0 +1,24 @@
> +Device-Tree bindings for the NXP TDA998x HDMI transmitter
> +
> +Required properties;
> +  - compatible: must be "nxp,tda998x"
> +
> +Optional properties:
> +  - interrupts: interrupt number for HDMI exchanges - default: by polling

What are HDMI exchanges, and how do they differ from other interrupts?

> +
> +  - pinctrl-0: pin control group to be used for this controller (IRQ).
> +
> +  - pinctrl-names: must contain a "default" entry.
> +
> +  - video-ports: 24 bits value - default: <0x230145>

What is this?


-Olof
