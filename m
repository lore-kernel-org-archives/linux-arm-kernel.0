From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 20 Aug 2012 22:30:44 +0800
Subject: [PATCH 1/2] clk: add of_clk_src_onecell_get() support
In-Reply-To: <1345104526-14797-2-git-send-email-shawn.guo@linaro.org>
References: <1345104526-14797-1-git-send-email-shawn.guo@linaro.org>
 <1345104526-14797-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120820143042.GL24242@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 16, 2012 at 04:08:45PM +0800, Shawn Guo wrote:
> For those SoCs that have hundreds of clock outputs, their clock
> DT bindings could reasonably define #clock-cells as 1 and require
> the client device specify the index of the clock it consumes in the
> cell of its "clocks" phandle.
> 
> Add a generic of_clk_src_onecell_get() function for this purpose.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/clk/clk.c            |   15 +++++++++++++++
>  include/linux/clk-provider.h |    1 +
>  2 files changed, 16 insertions(+), 0 deletions(-)
> 
Mike,

Can you please apply this patch on clk tree if it looks good to you?
I plan to ask arm-soc people pull in clk tree as dependency and then
have the other 3 patches in the series to go via arm-soc tree.

Regards,
Shawn
