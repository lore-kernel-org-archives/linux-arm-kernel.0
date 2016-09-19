From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 19 Sep 2016 16:12:33 -0300
Subject: [RFC PATCH v3 1/2] ARM: dts: samsung: add rga-lvds panel in itop
 elite
In-Reply-To: <1474311771-23321-2-git-send-email-ayaka@soulik.info>
References: <1474311771-23321-1-git-send-email-ayaka@soulik.info>
 <1474311771-23321-2-git-send-email-ayaka@soulik.info>
Message-ID: <CAOMZO5Agngx7b24bo3w7S84xtwZV81c-wAszs0B96FZhMeMW8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2016 at 4:02 PM, Randy Li <ayaka@soulik.info> wrote:

> +       vcc_sys_lcd: sys-lcd {
> +               compatible = "regulator-fixed";
> +               regulator-name = "vcc_5v";
> +               regulator-min-microvolt = <5000000>;
> +               regulator-max-microvolt = <5000000>;
> +               gpio = <&gpl0 4 GPIO_ACTIVE_HIGH>;

Is this really active high? If so, you should add the
'enable-active-high' property.
