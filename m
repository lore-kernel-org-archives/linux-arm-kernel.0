From: robh@kernel.org (Rob Herring)
Date: Mon, 11 Jul 2016 09:34:14 -0500
Subject: [PATCH 1/3] net: stmmac: dwmac-rk: add rk3366 & rk3399-specific
 data
In-Reply-To: <1467802291-6487-2-git-send-email-roger.chen@rock-chips.com>
References: <1467802291-6487-1-git-send-email-roger.chen@rock-chips.com>
 <1467802291-6487-2-git-send-email-roger.chen@rock-chips.com>
Message-ID: <20160711143414.GA8707@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2016 at 06:51:29PM +0800, Roger Chen wrote:
> Add constants and callback functions for the dwmac on rk3368 socs.
> As can be seen, the base structure is the same, only registers and
> the bits in them moved slightly.
> 
> Signed-off-by: Roger Chen <roger.chen@rock-chips.com>
> ---
>  .../devicetree/bindings/net/rockchip-dwmac.txt     |   3 +-

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     | 226 +++++++++++++++++++++
>  2 files changed, 228 insertions(+), 1 deletion(-)
