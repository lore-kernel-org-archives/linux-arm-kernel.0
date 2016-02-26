From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 26 Feb 2016 02:13:48 +0100
Subject: [RESEND PATCH] clk: rockchip: include downstream muxes into
 fractional dividers on rk3368
In-Reply-To: <1456274651-23202-1-git-send-email-zhangqing@rock-chips.com>
References: <1456274651-23202-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <4704515.DI1k3PeUbF@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 24. Februar 2016, 08:44:11 schrieb Elaine Zhang:
> During the initial conversion to the newly introduced combined fractional
> dividers+muxes the rk3368 clocks were left out, so convert them now.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>

applied to my clk-branch

Thanks
Heiko
