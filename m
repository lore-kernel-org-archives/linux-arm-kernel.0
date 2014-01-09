From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 9 Jan 2014 15:45:16 +0100
Subject: [PATCH 2/3] mmc: dw_mmc: add dw_mmc-k3 for k3 platform
In-Reply-To: <1389278112-7099-3-git-send-email-zhangfei.gao@linaro.org>
References: <1389278112-7099-1-git-send-email-zhangfei.gao@linaro.org>
 <1389278112-7099-3-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <201401091545.16671.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 09 January 2014, Zhangfei Gao wrote:
> Add dw_mmc-k3.c for k3v2, support sd/emmc
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: Zhigang Wang <brooke.wangzhigang@huawei.com>

This looks basically, sorry for taking so long for the review.
I thought there were a couple of tricky bugs in there, but
discussing them on IRC showed that I was wrong about all of them.

Acked-by: Arnd Bergmann <arnd@arndb.de>
