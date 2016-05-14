From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 14 May 2016 19:01:23 +0200
Subject: [PATCH v4 1/3] ARM64: dts: rockchip: make rk3399's grf a
 "simple-mfd"
In-Reply-To: <1463177524-113856-1-git-send-email-briannorris@chromium.org>
References: <1463177524-113856-1-git-send-email-briannorris@chromium.org>
Message-ID: <2246118.hzaJHK3UnE@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 13. Mai 2016, 15:12:02 schrieb Brian Norris:
> Per the examples in
> Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt, we need the
> grf node to be a simple-mfd in order to properly enumerate child devices
> like our eMMC PHY.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>

applied all 3 for 4.8 with the received Reviews.

Please keep the arm64 lower-case and carry over already received 
Acks/Reviews (Shawn and Doug on patch2 in v2).


Thanks
Heiko
