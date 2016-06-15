From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 15 Jun 2016 13:59:19 -0300
Subject: [PATCH] ARM: dts: imx6ul-pico-hobbit: Fix Ethernet PHY reset GPIO
In-Reply-To: <1466008481-10576-1-git-send-email-diego.dorta@nxp.com>
References: <1466008481-10576-1-git-send-email-diego.dorta@nxp.com>
Message-ID: <CAOMZO5BQd4bt7Uks9Yay+xheqLk_5bV5k_3xyR3uGSfMKxZW7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2016 at 1:34 PM, Diego Dorta <diego.dorta@nxp.com> wrote:
> According to the imx6ul-pico-hobbit schematics the Ethernet PHY reset GPIO
> is GPIO1_28, so fix it accordingly.
>
> Also adjust the reset duration to 1ms, because the KSZ8081 datasheet
> requires 500?s.
>
> Signed-off-by: Diego Dorta <diego.dorta@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
