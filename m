From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 25 Sep 2014 15:01:19 -0700
Subject: [PATCH 0/2] Add clock binding id for rk3288
In-Reply-To: <1411565795-26966-1-git-send-email-kever.yang@rock-chips.com>
References: <1411565795-26966-1-git-send-email-kever.yang@rock-chips.com>
Message-ID: <20140925220119.19023.81611@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Kever Yang (2014-09-24 06:36:33)
> This patch add some clock binding id for different modules
> that under development and going to send upstream.
> 
> This patch also add the clock node in PD_VIDEO.

Applied both patches to clk-next and fixed up the comment block locally.

Regards,
Mike

> 
> 
> Kever Yang (2):
>   clk: rockchip: add some needed clock binding id for rk3288
>   clk: rockchip: use the clock id for nodes init
> 
>  drivers/clk/rockchip/clk-rk3288.c      | 79 +++++++++++++++++++---------------
>  include/dt-bindings/clock/rk3288-cru.h | 38 +++++++++++++++-
>  2 files changed, 82 insertions(+), 35 deletions(-)
> 
> -- 
> 1.9.1
> 
