From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 31 May 2017 01:08:23 -0300
Subject: [PATCH 1/2] ARM: dts: imx6ul-14x14-evk: Add ksz8081 phy properties
In-Reply-To: <d31aab90fbdecaf4c5f240becb2d0b0efb23f5c3.1496164448.git.leonard.crestez@nxp.com>
References: <cover.1496164448.git.leonard.crestez@nxp.com>
 <d31aab90fbdecaf4c5f240becb2d0b0efb23f5c3.1496164448.git.leonard.crestez@nxp.com>
Message-ID: <CAOMZO5A8BaehXMcJ38k24OMV7P-edXZsS8JZ5wefOcyCu1jOOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 30, 2017 at 2:34 PM, Leonard Crestez
<leonard.crestez@nxp.com> wrote:
> Right now mach-imx6ul registers a fixup for the ksz8081 phy. The same
> register values can be set through the micrel phy driver by using dts
> properties.
>
> This seems preferable and allows cleanly fixing suspend/resume.
>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
