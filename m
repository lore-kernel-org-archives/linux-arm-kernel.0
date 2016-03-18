From: robh@kernel.org (Rob Herring)
Date: Fri, 18 Mar 2016 15:22:58 -0500
Subject: [PATCH v3 1/9] net: arc_emac: make the rockchip emac document
 more compatible
In-Reply-To: <1457942520-12859-2-git-send-email-wxt@rock-chips.com>
References: <1457942520-12859-1-git-send-email-wxt@rock-chips.com>
 <1457942520-12859-2-git-send-email-wxt@rock-chips.com>
Message-ID: <20160318202258.GA5642@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 14, 2016 at 04:01:52PM +0800, Caesar Wang wrote:
> Add the rk3036 SoCs to match driver for document since the emac driver
> has supported the rk3036 SoCs.
> 
> This patch adds the rk3036/rk3066/rk3188 SoCS to compatible for rockchip
> emac ducument. Also, that will suit for other SoCs in the future.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree at vger.kernel.org
> Cc: netdev at vger.kernel.org
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Alexander Kochetkov <al.kochet@gmail.com>
> 
> ---
> 
> Changes in v3:
> - %s/he/the
> - Add the Cc people
> 
> Changes in v2:
> - change the commit and remove the repeat the name 'rockchip'.
> 
>  Documentation/devicetree/bindings/net/emac_rockchip.txt | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
