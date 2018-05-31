From: robh@kernel.org (Rob Herring)
Date: Wed, 30 May 2018 22:07:15 -0500
Subject: [PATCH v4 2/5] clk: imx6: add EPIT clock support
In-Reply-To: <20180530120327.27681-3-peron.clem@gmail.com>
References: <20180530120327.27681-1-peron.clem@gmail.com>
 <20180530120327.27681-3-peron.clem@gmail.com>
Message-ID: <20180531030715.GA28712@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2018 at 02:03:24PM +0200, Cl?ment P?ron wrote:
> From: Colin Didier <colin.didier@devialet.com>
> 
> Add EPIT clock support to the i.MX6Q clocking infrastructure.
> 
> Signed-off-by: Colin Didier <colin.didier@devialet.com>
> Signed-off-by: Cl?ment Peron <clement.peron@devialet.com>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  drivers/clk/imx/clk-imx6q.c               | 2 ++
>  include/dt-bindings/clock/imx6qdl-clock.h | 4 +++-

Acked-by: Rob Herring <robh@kernel.org>

>  2 files changed, 5 insertions(+), 1 deletion(-)
