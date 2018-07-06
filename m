From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 06 Jul 2018 10:52:33 +0200
Subject: [PATCH] arm64: dts: rockchip: corrected uart1 clock-names for
 rk3328
In-Reply-To: <1530864237-14891-1-git-send-email-huibin.hong@rock-chips.com>
References: <1530864237-14891-1-git-send-email-huibin.hong@rock-chips.com>
Message-ID: <4047306.zuHpop0b3Q@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Huibin,

Am Freitag, 6. Juli 2018, 10:03:57 CEST schrieb Huibin Hong:
> Corrected the uart clock-names or the uart driver might fail.
> 
> Signed-off-by: Huibin Hong <huibin.hong@rock-chips.com>

thanks for catching that issue. I've added a Fixes-tag and a stable-cc
and applied the patch for 4.19


Thanks
Heiko
