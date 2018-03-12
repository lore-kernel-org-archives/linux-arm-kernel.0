From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 12 Mar 2018 11:52:54 +0100
Subject: [PATCH] arm64: dts: rockchip: assign clock rate for ACLK_VIO
In-Reply-To: <1520819448-8316-1-git-send-email-zhengsq@rock-chips.com>
References: <1520819448-8316-1-git-send-email-zhengsq@rock-chips.com>
Message-ID: <4610682.YhluMk2iks@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 12. M?rz 2018, 02:50:48 CET schrieb Shunqian Zheng:
> The ACLK_VIO is a parent clock used by a several children,
> its suggested clock rate is 400MHz. Right now it gets 400MHz
> because it sources from CPLL(800M) and divides by 2 after reset.
> It's good not to rely on default values like this, so let's
> explicitly set it.
> NOTE: it's expected that at least one board may override cru node and
> set the CPLL to 1.6 GHz. On that board it will be very important to be
> explicit about aclk-vio being 400 MHz.
> 
> Signed-off-by: Shunqian Zheng <zhengsq@rock-chips.com>

applied for 4.17

Thanks
Heiko
