From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 11 Jan 2016 12:36:51 +0100
Subject: [PATCH] ARM: dts: rockchip: Add support emac for RK3036
In-Reply-To: <1452217026-21155-1-git-send-email-zhengxing@rock-chips.com>
References: <1452217026-21155-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <2062991.rcWfmTiAzP@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 8. Januar 2016, 09:37:06 schrieb Xing Zheng:
> This patch describe the emac, and we need to let mac clock under
> the APLL which is able to provide the accurate 50MHz what mac_ref
> need.
> 
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>

I've queued this to get applied after 4.5-rc1 is out and I have a clean base 
again to add the needed shared clock-branch.


Heiko
