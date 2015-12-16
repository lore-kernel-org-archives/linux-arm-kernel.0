From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 16 Dec 2015 22:24:50 +0100
Subject: [PATCH 2/5] clk: rockchip: rk3036: enable the CLK_IGNORE_UNUSED
 flag for aclk_vio
In-Reply-To: <1450254441-3243-3-git-send-email-wxt@rock-chips.com>
References: <1450254441-3243-1-git-send-email-wxt@rock-chips.com>
 <1450254441-3243-3-git-send-email-wxt@rock-chips.com>
Message-ID: <1859046.avFUcYTcgb@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 16. Dezember 2015, 16:27:18 schrieb Caesar Wang:
> From: Yakir Yang <ykk@rock-chips.com>
> 
> ACLK_VIO is the noc bus clock for display module, display cann't
> read data from ddr without this clock enabled.
> 
> Due to it shouldn't belong to any driver, but we need it enabled,
> so just mark it as the CLK_IGNORE_UNUSED flag.
> 
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>

applied to my clk-branch for 4.5


Thanks
Heiko
