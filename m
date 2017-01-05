From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 05 Jan 2017 15:07:20 +0100
Subject: [PATCH v1 0/3] soc: rockchip: power-domain: support RK3328 SoC
In-Reply-To: <1482464872-12954-1-git-send-email-zhangqing@rock-chips.com>
References: <1482464872-12954-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <4525049.9DCCQ7XhES@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 23. Dezember 2016, 11:47:49 CET schrieb Elaine Zhang:
> Elaine Zhang (3):
>   dt/bindings: power: add RK3328 SoCs header for idle-request
>   dt-bindings: add binding for rk3328 power domains
>   soc: rockchip: power-domain: Modify power domain driver for rk3328
> 
>  .../bindings/soc/rockchip/power_domain.txt         |  3 ++
>  drivers/soc/rockchip/pm_domains.c                  | 63
> +++++++++++++++++++--- include/dt-bindings/power/rk3328-power.h           |
> 18 +++++++
>  3 files changed, 78 insertions(+), 6 deletions(-)
>  create mode 100644 include/dt-bindings/power/rk3328-power.h

I've split patch 3 into two parts (hiword support and rk3328 addition) and 
applied all for 4.11


Thanks
Heiko
