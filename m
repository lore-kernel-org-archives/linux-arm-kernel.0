From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 2 May 2018 14:27:02 +0200
Subject: [PATCH 4/6] pinctrl: fsl: add scu based pinctrl support
In-Reply-To: <1524855713-15527-5-git-send-email-aisheng.dong@nxp.com>
References: <1524855713-15527-1-git-send-email-aisheng.dong@nxp.com>
 <1524855713-15527-5-git-send-email-aisheng.dong@nxp.com>
Message-ID: <CACRpkdY5zSNYvXD3icbO+4R7Mc7TDhHCoUU0gikE6A+=ZFA=Kg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2018 at 9:01 PM, Dong Aisheng <aisheng.dong@nxp.com> wrote:

> Some i.MX SoCs (e.g. MX8QXP and MX8QM) contain a system controller
> that is responsible for controlling the pad setting of the IPs that
> are present. Communication between the host processor running an OS
> and the system controller happens through a SCU protocol.
> This patch adds SCU protocol based pinctrl drivers.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Patch applied.

There was some controversy about i.MX pin control some time
back so I hope there is no annoyance from the other maintainers
that I just merge stuff from one maintainer.

If you don't like the patches you can always tell me to drop
them.

Yours,
Linus Walleij
