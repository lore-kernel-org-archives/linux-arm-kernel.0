From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 8 May 2014 10:45:39 -0300
Subject: [PATCH v2] ARM: dts: imx6: add new board RIoTboard
In-Reply-To: <536B4ACD.30001@gmail.com>
References: <53695C34.5000604@gmail.com> <20140508054106.GH2794@dragon>
 <536B4ACD.30001@gmail.com>
Message-ID: <CAOMZO5AMf74btETX9zM97B-rCRAVh9-s=N4=xqTMifuucwqURg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 8, 2014 at 6:13 AM, Iain Paton <ipaton0@gmail.com> wrote:
> add element14s RIoTboard http://www.riotboard.org which is an i.MX6Solo
> based design targeted at makers.
>
> Signed-off-by: Iain Paton<ipaton0@gmail.com>

Looks good. One comment only:


> +&i2c4 {
> +       clock-frequency = <100000>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_i2c4>;
> +       clocks = <&clks 116>;

You could remove this 'clocks' line.
