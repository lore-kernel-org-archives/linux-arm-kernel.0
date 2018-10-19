From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 19 Oct 2018 13:26:20 -0300
Subject: [PATCH] ARM: dts: imx6ul: ccimx6ulsom: Add support for wireless
 SOM variant
In-Reply-To: <1539962141-32418-2-git-send-email-alex.gonzalez@digi.com>
References: <1539962141-32418-1-git-send-email-alex.gonzalez@digi.com>
 <1539962141-32418-2-git-send-email-alex.gonzalez@digi.com>
Message-ID: <CAOMZO5BwqT5Y5xECqnLx6K6Vv2gur4HV2g6zJDJyDot5FdX+KQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alex,

On Fri, Oct 19, 2018 at 12:17 PM Alex Gonzalez <alex.gonzalez@digi.com> wrote:

> +/* USDHC1 (Wireless) */
> +&usdhc1 {
> +       pinctrl-names = "default", "sleep";
> +       pinctrl-0 = <&pinctrl_usdhc1 &pinctrl_wifibt_ctrl>;
> +       pinctrl-1 = <&pinctrl_usdhc1_sleep &pinctrl_wifibt_ctrl_sleep>;
> +       non-removable;
> +       no-1-8-v;
> +       bus-width = <4>;
> +       status = "okay";
> +};
> +
> +

Just a minor not: only one blank line is enough.

Reviewed-by: Fabio Estevam <festevam@gmail.com>
