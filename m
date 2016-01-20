From: zhangqing@rock-chips.com (zhangqing)
Date: Wed, 20 Jan 2016 02:28:05 -0800
Subject: [PATCH v3 0/3] SoC: rockchip: support power domain for RK3368
In-Reply-To: <1452508600-3512-1-git-send-email-zhangqing@rock-chips.com>
References: <1452508600-3512-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <569F6135.1070902@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/11/2016 02:36 AM, zhangqing wrote:
> add pd id in rk3368-power.h
> modify pm_domains.c to support RK3368 SoC
> add RK3368 document for Rockchip power domains
>
> zhangqing (3):
>    dt-bindings: add power-domain header for RK3368 SoCs
>    soc: rockchip: power-domain: Modify power domain driver for rk3368
>    dt-bindings: modify document of Rockchip power domains

Are there any other questions about the three patches.Please review.
>
>   .../bindings/soc/rockchip/power_domain.txt         | 21 ++++++++++++++
>   drivers/soc/rockchip/pm_domains.c                  | 33 ++++++++++++++++++++++
>   include/dt-bindings/power/rk3368-power.h           | 28 ++++++++++++++++++
>   3 files changed, 82 insertions(+)
>   create mode 100644 include/dt-bindings/power/rk3368-power.h
>
