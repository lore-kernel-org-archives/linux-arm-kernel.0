From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 17 May 2017 20:10:48 +0200
Subject: [PATCH v2 1/3] arm: dts: rk322x: fix i2s1 pinctrl error
In-Reply-To: <1495014746-27621-2-git-send-email-frank.wang@rock-chips.com>
References: <1495014746-27621-1-git-send-email-frank.wang@rock-chips.com>
 <1495014746-27621-2-git-send-email-frank.wang@rock-chips.com>
Message-ID: <1634694.eXjXQc2COO@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 17. Mai 2017, 17:52:24 CEST schrieb Frank Wang:
> From: Sugar Zhang <sugar.zhang@rock-chips.com>
> 
> Refer to Chapter 5.3.2 of rk3229 TRM, we can see that GPIO1A[2,4,5]
> using RK_FUNC_2 not RK_FUNC_1. This patch fixes it.
> 
> Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>

applied for 4.13, after fixing the subject up a bit (ARM: dts: rockchip: ...)


Thanks
Heiko
