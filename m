From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 16 Apr 2018 10:36:18 +0100
Subject: [PATCH 1/3] mfd: axp20x: Const-ify struct mfd_cell and struct
 resource
In-Reply-To: <20180329043115.7132-2-wens@csie.org>
References: <20180329043115.7132-1-wens@csie.org>
 <20180329043115.7132-2-wens@csie.org>
Message-ID: <20180416093618.2ajissetbjfpjck5@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 29 Mar 2018, Chen-Yu Tsai wrote:

> The axp20x driver has lots of mfd_cell and resource structs.
> These can all be const-ified.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/mfd/axp20x.c       | 44 ++++++++++++++++++++++----------------------
>  include/linux/mfd/axp20x.h |  2 +-
>  2 files changed, 23 insertions(+), 23 deletions(-)

Applied, thanks.

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
