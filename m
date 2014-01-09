From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 9 Jan 2014 15:38:07 +0100
Subject: [PATCH 3/3] clk: hisilicon: add hi3620_mmc_clks
In-Reply-To: <1389278112-7099-4-git-send-email-zhangfei.gao@linaro.org>
References: <1389278112-7099-1-git-send-email-zhangfei.gao@linaro.org>
 <1389278112-7099-4-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <201401091538.07496.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 09 January 2014, Zhangfei Gao wrote:
> Suggest by Arnd: abstract mmc tuning as clock behavior,
> also because different soc have different tuning method and registers.
> hi3620_mmc_clks is added to handle mmc clock specifically on hi3620.
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
