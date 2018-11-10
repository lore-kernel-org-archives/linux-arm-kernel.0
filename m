From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 10 Nov 2018 13:52:34 -0200
Subject: [PATCH V5 4/6] dts: imx: add common imx7ulp dtsi support
In-Reply-To: <1541862478-7839-5-git-send-email-aisheng.dong@nxp.com>
References: <1541862478-7839-1-git-send-email-aisheng.dong@nxp.com>
 <1541862478-7839-5-git-send-email-aisheng.dong@nxp.com>
Message-ID: <CAOMZO5DJgEfzrZQkY1czdrR_fxwdEP5JoTuWKBeS1v35mDA2KQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 10, 2018 at 1:13 PM A.s. Dong <aisheng.dong@nxp.com> wrote:
>
> The i.MX 7ULP family of processors features NXP's advanced implementation
> of the Arm Cortex-A7 core, the Arm Cortex-M4 core, as well as a 3D and 2D
> Graphics Processing Units (GPUs).
>
> This patch aims to add the initial support including:
> 1) CLK
> 2) GPIO PTC, PTD, PTE, PTF
> 3) uSDHC 1/2
> 4) LPUART 4/5/6/7
> 5) LPI2C 6/7
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: devicetree at vger.kernel.org
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
