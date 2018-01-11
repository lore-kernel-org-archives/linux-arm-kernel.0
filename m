From: robh@kernel.org (Rob Herring)
Date: Thu, 11 Jan 2018 16:10:50 -0600
Subject: [PATCH V4 1/2] clk: imx: imx7d: add the snvs clock
In-Reply-To: <1515491526-14060-1-git-send-email-Anson.Huang@nxp.com>
References: <1515491526-14060-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20180111221050.cjogg4xbsxbhqrrv@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 09, 2018 at 05:52:05PM +0800, Anson Huang wrote:
> According to the i.MX7D Reference Manual,
> SNVS block has a clock gate, accessing SNVS block
> would need this clock gate to be enabled, add it
> into clock tree so that SNVS module driver can
> operate this clock gate.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Acked-by: Dong Aisheng <aisheng.dong@nxp.com>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  drivers/clk/imx/clk-imx7d.c             | 1 +
>  include/dt-bindings/clock/imx7d-clock.h | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
