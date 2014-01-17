From: tgih.jun@samsung.com (Seungwon Jeon)
Date: Fri, 17 Jan 2014 23:43:36 +0900
Subject: [PATCH 2/2] mmc: dw_mmc: k3: remove clk_table
References: <1389604469-8064-1-git-send-email-zhangfei.gao@linaro.org>
 <1389604469-8064-3-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <000601cf1392$80cdd600$82698200$%jun@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Chris Ball (New e-mail)

On Tue, January 14, 2014, Seungwon Jeon wrote:
> On Monday, January 13, 2014, Zhangfei Gao wrote:
> > Remove clk_table and directly use ios->clock as clock source rate.
> > Abstract init clock rate and max clock limitation in clk.c
> >
> > Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> 
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
> 
> Thanks,
> Seungwon Jeon
