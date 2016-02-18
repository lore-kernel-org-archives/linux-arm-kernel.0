From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 19 Feb 2016 00:48:44 +0100
Subject: [PATCH v2 0/6] rockchip: power-domain: fix pm domain for support
 RK3399 SoC
In-Reply-To: <1455764838-12928-1-git-send-email-zhangqing@rock-chips.com>
References: <1455764838-12928-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1552427.8VgrhmbCO1@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Elaine,

your sending mechanism could use some improvements :-)
I always get patches 1-4 correctly as replies to the cover-letter while 
patches 5+6 always come separately (missing in-reply-to?).

I guess using git send-email might help with that.

Also, Kevin Hilman was very involved in reviewing the original Rockchip 
power-domain driver, so it might be nice to include him in further versions.


Heiko

Am Donnerstag, 18. Februar 2016, 11:07:12 schrieb Elaine Zhang:
> fix some idle handling
> support sub-power domain
> add rk3399-power.h
> modify power domain for RK3399 SoC
> modify document for RK3399 Soc
> 
> Elaine Zhang (6):
>   rockchip: power-domain: make idle handling optional
>   rockchip: power-domain: allow domains only handling idle requests
>   rockchip: power-domain: add support for sub-power domains
>   dt/bindings: power: add RK3399 SoCs header for power-domain
>   rockchip: power-domain: Modify power domain driver for rk3399
>   dt/bindings: rockchip: modify document of Rockchip power domains
> 
>  .../bindings/soc/rockchip/power_domain.txt         |  21 ++++
>  drivers/soc/rockchip/pm_domains.c                  | 131
> ++++++++++++++++++++- include/dt-bindings/power/rk3399-power.h          
> |  53 +++++++++ 3 files changed, 200 insertions(+), 5 deletions(-)
>  create mode 100644 include/dt-bindings/power/rk3399-power.h
