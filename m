From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 18 Jun 2018 13:32:14 -0300
Subject: [PATCH] ARM: dts: imx7d-sdb: Remove duplicate regulator-can2-3v3
In-Reply-To: <abacbb7485b0c9b908eae8ae87be9d8e0eab87b3.1529327283.git.leonard.crestez@nxp.com>
References: <abacbb7485b0c9b908eae8ae87be9d8e0eab87b3.1529327283.git.leonard.crestez@nxp.com>
Message-ID: <CAOMZO5AJH=Ay4MPt1Gi8LxmUSfhg3dMdcHRjsFzzQ9ZxD72TjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2018 at 10:11 AM, Leonard Crestez
<leonard.crestez@nxp.com> wrote:
> Two different regulators are defined with the same name and label but
> distinct properties.
>
> The first definition was added with the first board dts and the second
> was added when upstream added flexcan support.
>
> Looking at schematics it is indeed gpio2 14 connected to the STB pin of
> the CAN transceiver so remove the first definition.
>
> The second definition entirely overrides the first so this already
> worked and this patch results in no DTB change, just a cleanup.
>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
