From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 16 Dec 2017 12:05:25 -0200
Subject: [PATCH 8/9] ARM: dts: imx7-colibri: add MCP2515 CAN controller
In-Reply-To: <20171206153005.6144-8-stefan@agner.ch>
References: <20171206153005.6144-1-stefan@agner.ch>
 <20171206153005.6144-8-stefan@agner.ch>
Message-ID: <CAOMZO5AcUiGaZrHyJCS7By1gO2hUEtMB-MVABwXy2SLV6ExW6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 6, 2017 at 1:30 PM, Stefan Agner <stefan@agner.ch> wrote:

> +&ecspi3 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_ecspi3 &pinctrl_ecspi3_cs>;
> +       num-cs = <1>;

num-cs can be dropped.
