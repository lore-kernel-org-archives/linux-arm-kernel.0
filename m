From: zhangfei.gao@linaro.org (zhangfei)
Date: Fri, 20 Dec 2013 10:31:07 +0800
Subject: [PATCH 2/3] mmc: dw_mmc: add dw_mmc-k3 for k3 platform
In-Reply-To: <1387199536-7053-1-git-send-email-zhangfei.gao@linaro.org>
References: <1386987174-1788-3-git-send-email-zhangfei.gao@linaro.org>
 <1387199536-7053-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <52B3ABEB.2010502@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/16/2013 09:12 PM, Zhangfei Gao wrote:
> Add dw_mmc-k3.c for k3v2, support sd/emmc
>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: Zhigang Wang <brooke.wangzhigang@huawei.com>
> ---
>   .../devicetree/bindings/mmc/k3-dw-mshc.txt         |   60 +++++++++
>   drivers/mmc/host/Kconfig                           |   10 ++
>   drivers/mmc/host/Makefile                          |    1 +
>   drivers/mmc/host/dw_mmc-k3.c                       |  134 ++++++++++++++++++++
>   4 files changed, 205 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
>   create mode 100644 drivers/mmc/host/dw_mmc-k3.c
>

Any comments?

Thanks
