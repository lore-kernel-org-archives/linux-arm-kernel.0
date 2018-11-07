From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 7 Nov 2018 08:03:09 -0200
Subject: [PATCH] ARM: dts: imx7d-sdb: add rev-a board support
In-Reply-To: <1541567625-11812-1-git-send-email-Anson.Huang@nxp.com>
References: <1541567625-11812-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <CAOMZO5AL03yy6Vj_eC=h7scSDnuja1G8rsWER+r7w3FEVaceDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anson,

On Wed, Nov 7, 2018 at 3:19 AM Anson Huang <anson.huang@nxp.com> wrote:

> +&fec2 {
> +       pinctrl-0 = <&pinctrl_enet2>;
> +       /delete-property/pinctrl-assert-gpios;

"pinctrl-assert-gpios" does not exist in mainline, so not sure why you
are deleting it.
