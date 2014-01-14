From: tgih.jun@samsung.com (Seungwon Jeon)
Date: Tue, 14 Jan 2014 19:42:19 +0900
Subject: [PATCH 2/2] mmc: dw_mmc: k3: remove clk_table
In-Reply-To: <1389604469-8064-3-git-send-email-zhangfei.gao@linaro.org>
References: <1389604469-8064-1-git-send-email-zhangfei.gao@linaro.org>
 <1389604469-8064-3-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <002b01cf1115$4cdfe240$e69fa6c0$%jun@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, January 13, 2014, Zhangfei Gao wrote:
> Remove clk_table and directly use ios->clock as clock source rate.
> Abstract init clock rate and max clock limitation in clk.c
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>

Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

Thanks,
Seungwon Jeon
