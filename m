From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 08 Jul 2016 00:35:57 +0200
Subject: [PATCH v1 5/5] ARM: dts: rockchip: add the panel power supply for
 rk3288-evb board with rk808 pmu
In-Reply-To: <1467089484-18756-1-git-send-email-ykk@rock-chips.com>
References: <1467089288-18355-1-git-send-email-ykk@rock-chips.com>
 <1467089484-18756-1-git-send-email-ykk@rock-chips.com>
Message-ID: <5331482.3zk2CO4kJV@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 28. Juni 2016, 12:51:24 schrieb Yakir Yang:
> Panel regulator is controller by a normal GPIO, so we need to
> write a regulator-fixed node for it.
> 
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>

applied after rewording the commit message a bit.
On the rk808-evb vcc_lcd comes from the rk808 directly and not through some 
gpio regulator :-) .


Heiko
