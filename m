From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 30 May 2016 13:54:43 -0300
Subject: [PATCH 5/5] arm/dts/imx6q-b850v3: Use GE B850v3 LVDS/DP++ Bridge
In-Reply-To: <1464626385-19253-6-git-send-email-peter.senna@collabora.com>
References: <1464626385-19253-1-git-send-email-peter.senna@collabora.com>
 <1464626385-19253-6-git-send-email-peter.senna@collabora.com>
Message-ID: <CAOMZO5CigjkoKoHdWROYwz=76OjbA8bTsrgG4VVQymKPZeUtUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 30, 2016 at 1:39 PM, Peter Senna Tschudin
<peter.senna@collabora.com> wrote:

> +&mux2_i2c2 {
> +       status = "okay";
> +       clock-frequency = <100000>;
> +
> +       b850v3_lvds_dp_bridge {
> +               compatible = "ge,b850v3_lvds_dp";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               reg = <0x73>;

You use 'reg = <0x73>' here, but no @73.
