From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Oct 2015 13:22:42 +0200
Subject: [PATCH] of/irq: export of_irq_count
In-Reply-To: <1444905402-10510-1-git-send-email-zhangfei.gao@linaro.org>
References: <1444905402-10510-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <5751366.GyyqTKdeqL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 October 2015 18:36:42 Zhangfei Gao wrote:
> Export of_irq_count, otherwise module build fail if of_irq_count is used
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: John Garry <john.garry@huawei.com>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
