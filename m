From: robh@kernel.org (Rob Herring)
Date: Fri, 4 Mar 2016 22:30:35 -0600
Subject: [PATCH] ASoC: rockchip: add bindings for spdif controller
In-Reply-To: <1457087514-1837-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1457087514-1837-1-git-send-email-sugar.zhang@rock-chips.com>
Message-ID: <20160305043035.GF13525@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 04, 2016 at 06:31:54PM +0800, Sugar Zhang wrote:
> this patch add compatible for rk3366/rk3368/rk3399 spdif,
> these three spdifs share the same type.
> 
> Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
> ---
> 
>  Documentation/devicetree/bindings/sound/rockchip-spdif.txt |  8 ++++++--
>  sound/soc/rockchip/rockchip_spdif.c                        | 13 ++++++++++---
>  2 files changed, 16 insertions(+), 5 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
