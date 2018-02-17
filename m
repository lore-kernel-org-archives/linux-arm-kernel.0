From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 17 Feb 2018 01:10:27 +0100
Subject: [PATCH v3 5/6] phy: rockchip-typec: support DP phy switch
In-Reply-To: <20180216120956.19034-5-enric.balletbo@collabora.com>
References: <20180216120956.19034-1-enric.balletbo@collabora.com>
 <20180216120956.19034-5-enric.balletbo@collabora.com>
Message-ID: <2116429.ju84df7Jza@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 16. Februar 2018, 13:09:55 CET schrieb Enric Balletbo i Serra:
> From: Chris Zhong <zyw@rock-chips.com>
> 
> There are 2 Type-c PHYs in RK3399, but only one DP controller. Hence
> only one PHY can connect to DP controller at one time, the other should
> be disconnected. The GRF_SOC_CON26 register has a switch bit to do it,
> set this bit means enable PHY 1, clear this bit means enable PHY 0.
> 
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
