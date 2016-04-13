From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 13 Apr 2016 22:57:01 +0200
Subject: [PATCH 2/2] ARM: dts: rockchip: add i2c nodes RK3228 SoCs
In-Reply-To: <1457925102-30476-1-git-send-email-ykk@rock-chips.com>
References: <1457924955-29996-1-git-send-email-ykk@rock-chips.com>
 <1457925102-30476-1-git-send-email-ykk@rock-chips.com>
Message-ID: <5295818.srcnokibua@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 14. M?rz 2016, 11:11:42 schrieb Yakir Yang:
> This patch add the i2c dt nodes for rk3228 SoCs.
> 
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>

applied to my dts32 branch for 4.7, after moving the i2c pinctrl nodes in 
between emmc and pwm* (please try to keep alphabetical ordering there)


Heiko
