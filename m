From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 19 Apr 2016 08:34:28 -0300
Subject: [PATCH v2] ARM: dts: imx6: Add dts for Embest MarS Board
In-Reply-To: <1460420743-30883-1-git-send-email-sergio.prado@e-labworks.com>
References: <1460420743-30883-1-git-send-email-sergio.prado@e-labworks.com>
Message-ID: <CAOMZO5AKdFtCZJSFg5ZJ2j8MBta_s=HSNBaH5a9zoTdkwQ477Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 11, 2016 at 9:25 PM, Sergio Prado
<sergio.prado@e-labworks.com> wrote:

> +&fec {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_enet>;
> +       phy-mode = "rgmii";
> +       phy-reset-gpios = <&gpio3 31 GPIO_ACTIVE_HIGH>;

Are you sure this is really active high?
