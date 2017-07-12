From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 13 Jul 2017 01:34:10 +0200
Subject: [RESEND PATCH v2 1/7] ARM: dts: rockchip: add cpu enable method
 for rk3228 SoC
In-Reply-To: <1498127402-6705-2-git-send-email-frank.wang@rock-chips.com>
References: <1498127402-6705-1-git-send-email-frank.wang@rock-chips.com>
 <1498127402-6705-2-git-send-email-frank.wang@rock-chips.com>
Message-ID: <48386264.sWdhVGKZz6@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 22. Juni 2017, 18:29:56 CEST schrieb Frank Wang:
> This patch sets PSCI as the default cpu enable-method for RK3228 SoC.
> 
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>

I've seen the work on OP-TEE mainlining for the psci implementation
which seems to be progressing nicely and with the code in the open
now, it's possible to replace the firmware if needed.

So I've applied this patch for 4.14.


Heiko
