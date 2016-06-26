From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 27 Jun 2016 01:09:08 +0200
Subject: [PATCH] arm64: dts: rockchip: add ap_pwroff and ddrio_pwroff pins
 for rk3399
In-Reply-To: <1465935671-13890-1-git-send-email-dianders@chromium.org>
References: <1465935671-13890-1-git-send-email-dianders@chromium.org>
Message-ID: <3506480.G5PcqxtUXs@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 14. Juni 2016, 13:21:11 schrieb Douglas Anderson:
> There are two sleep related pins on rk3399: ap_pwroff and ddrio_pwroff.
> Let's add the definition of these two pins to rk3399's main dtsi file so
> that boards can use them.
> 
> These two pins are similar to the global_pwroff and ddrio_pwroff pins in
> rk3288 and are expected to be used in the same way: boards will likely
> want to configure these pinctrl settings in their global pinctrl hog
> list.
> 
> Note that on rk3288 there were two additional pins in the "sleep"
> section: "ddr0_retention" and "ddr1_retention".  On rk3288 designs these
> pins appeared to actually route from rk3288 back to rk3288.  Presumably
> on rk3399 this is simply not needed since the pins don't appear to exist
> there.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

applied to my dts64 branch for 4.8


Thanks
Heiko
