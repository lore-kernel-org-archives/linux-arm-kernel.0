From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 16 Apr 2018 10:36:30 +0100
Subject: [PATCH 2/3] mfd: axp20x: Use DEFINE_RES_IRQ to declare resources
 for mfd_cells
In-Reply-To: <20180329043115.7132-3-wens@csie.org>
References: <20180329043115.7132-1-wens@csie.org>
 <20180329043115.7132-3-wens@csie.org>
Message-ID: <20180416093630.ytjtspxsrlppxa5z@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 29 Mar 2018, Chen-Yu Tsai wrote:

> Previously we were open coding the interrupts for the various mfd
> cells. This made the code somewhat long due to pretty-formatting.
> 
> This patch convert those into one-line declarations with DEFINE_RES_IRQ,
> making the code shorter and easier to read.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/mfd/axp20x.c | 187 +++++++++------------------------------------------
>  1 file changed, 30 insertions(+), 157 deletions(-)

Applied, thanks.

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
