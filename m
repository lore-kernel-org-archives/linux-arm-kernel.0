From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 17 Nov 2016 17:03:20 +0100
Subject: [PATCH 2/2] arm64: defconfig: enable MFD RK808 and RK808 regulator
In-Reply-To: <1473249028-27161-1-git-send-email-andy.yan@rock-chips.com>
References: <1473248790-27101-1-git-send-email-andy.yan@rock-chips.com>
 <1473249028-27161-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <1702189.LYSQd0C2WL@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 7. September 2016, 19:50:28 CET schrieb Andy Yan:
> Many rockchip based arm64 boards use RK808 as PMIC, so
> enabe it here let the board bootup normally.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

applied to a defconfig64 branch after adding rk808-rtc as module and rk808-clk 
output as builtin as well.


Thanks
Heiko
