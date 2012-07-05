From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 5 Jul 2012 11:15:28 +0800
Subject: [GIT PULL] clk/mxs for 3.6
In-Reply-To: <20120703020006.GA22106@S2101-09.ap.freescale.net>
References: <20120703020006.GA22106@S2101-09.ap.freescale.net>
Message-ID: <20120705031526.GH2595@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 03, 2012 at 10:00:09AM +0800, Shawn Guo wrote:
> The following changes since commit cfaf025112d3856637ff34a767ef785ef5cf2ca9:
> 
>   Linux 3.5-rc2 (2012-06-08 18:40:09 -0700)
> 
> are available in the git repository at:
>   git://git.linaro.org/people/shawnguo/linux-2.6.git clk/mxs-for-3.6
> 
> Fabio Estevam (1):
>       clk: mxs: Fix the GPMI clock name
> 
> Huang Shijie (1):
>       clk: mxs: rename the gpmi clock for imx28
> 
> Shawn Guo (1):
>       clk: mxs: add clkdev lookup for pwm
> 
>  drivers/clk/mxs/clk-imx23.c |    3 ++-
>  drivers/clk/mxs/clk-imx28.c |    3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)

Mike,

I just added one more patch on the branch.  Please pull it also.

Lauri Hintsala (1):
      clk: mxs: imx28: decrease the frequency of ref_io1 for SSP2 and SSP3

-- 
Regards,
Shawn
