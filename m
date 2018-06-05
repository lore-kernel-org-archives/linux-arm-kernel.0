From: robh@kernel.org (Rob Herring)
Date: Tue, 5 Jun 2018 15:10:09 -0600
Subject: [PATCH V2 1/2] clk: imx6ul: add GPIO clock gates
In-Reply-To: <1527990245-13619-1-git-send-email-Anson.Huang@nxp.com>
References: <1527990245-13619-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20180605211009.GA28373@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 03, 2018 at 09:44:04AM +0800, Anson Huang wrote:
> i.MX6UL has GPIO clock gates in CCM CCGR,
> add them into clock tree for clock management.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> changes since V1:
> 	Move IMX6UL_CLK_GPIOx definition to end of clock table;
> 	Based on Fabio's patch "[v2] dt-bindings: clock: imx6ul: Do not change the clock definition order".
>  drivers/clk/imx/clk-imx6ul.c             | 5 +++++
>  include/dt-bindings/clock/imx6ul-clock.h | 8 +++++++-
>  2 files changed, 12 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
