From: davem@davemloft.net (David Miller)
Date: Fri, 02 Sep 2016 17:09:12 -0700 (PDT)
Subject: [PATCH v4 0/6] Support the rk3399 gmac and pd function
In-Reply-To: <1472752204-8924-1-git-send-email-wxt@rock-chips.com>
References: <1472752204-8924-1-git-send-email-wxt@rock-chips.com>
Message-ID: <20160902.170912.186642163235206909.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Caesar Wang <wxt@rock-chips.com>
Date: Fri,  2 Sep 2016 01:49:58 +0800

> This patch have the following changes:
> 
> 7edf13e net: stmmac: dwmac-rk: add rk3366 & rk3399 specific data
> 26e004e net: stmmac: dwmac-rk: fixes the gmac resume after PD on/off
> b216c2f net: stmmac: dwmac-rk: add pd_gmac support for rk3399
> 848bb71 arm64: dts: rockchip: add the gmac power domain on rk3399
> 508e41f arm64: dts: rockchip: add the gmac needed node for rk3399
> fb26795 arm64: dts: rockchip: enable the gmac for rk3399 evb board
> 
> Hi David,
> The patch 1,2,3 is related to the rockchip net/stammc driver,
> 
> Hi Heiko,
> The patch 4,5,6 is related to the dts changes.

Patches 1, 2, and 3 applied to net-next, thanks.
