From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 15 Feb 2016 22:12:50 +0100
Subject: [PATCH] arm64: dts: rockchip: fix the incorrect otp-out pin on
 rk3368
In-Reply-To: <1455507058-10824-1-git-send-email-wxt@rock-chips.com>
References: <1455507058-10824-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1884614.IJaL3hhOqa@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Caesar,

Am Montag, 15. Februar 2016, 11:30:58 schrieb Caesar Wang:
> This patch fixes the incorrect Over-temperature protection pin.
> since the rk3368 io list said the otp pin is gpio0a3.
> 
> Anyway, that should be fixed in here.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>

applied to my dts branch for 4.6

Thanks
Heiko
