From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 31 Jan 2016 11:46:47 +0100
Subject: [PATCH v4 1/9] ARM: dts: rockchip: add the leds control for kylin
 board
In-Reply-To: <1453970618-4383-2-git-send-email-wxt@rock-chips.com>
References: <1453970618-4383-1-git-send-email-wxt@rock-chips.com>
 <1453970618-4383-2-git-send-email-wxt@rock-chips.com>
Message-ID: <2785565.JmZWWova7F@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 28. Januar 2016, 16:43:30 schrieb Caesar Wang:
> As the kylin schematic drawing, add the needed work led for
> kylin board.
> 
> Run:
> echo 0 > /sys/class/leds/kylin:red:led/brightness
> echo 1 > /sys/class/leds/kylin:red:led/brightness
> 
> The led can normal on/off on kylin board.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>

applied to my dts32-branch for 4.6
