From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 16 Feb 2016 22:28:05 -0200
Subject: [PATCH v2 2/3] ARM: dts: vf-colibri: add basic supply regulators
In-Reply-To: <1455668317-15728-2-git-send-email-stefan@agner.ch>
References: <1455668317-15728-1-git-send-email-stefan@agner.ch>
 <1455668317-15728-2-git-send-email-stefan@agner.ch>
Message-ID: <CAOMZO5Bb1eGSinoNkUhB_2w8mWdA+RQA0Z4geJp8B-MfGryAHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 16, 2016 at 10:18 PM, Stefan Agner <stefan@agner.ch> wrote:

> +       reg_module_3v3: regulator-module-3v3 {
> +               compatible = "regulator-fixed";
> +               regulator-name = "+V3.3";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +               regulator-always-on;

This 'regulator-always-on' property can be removed.

> +       };
> +
> +       reg_module_3v3_avdd: regulator-module-3v3-avdd {
> +               compatible = "regulator-fixed";
> +               regulator-name = "+V3.3_AVDD_AUDIO";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +               regulator-always-on;

Same here.
