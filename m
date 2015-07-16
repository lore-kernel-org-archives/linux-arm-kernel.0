From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 16 Jul 2015 14:22:41 +0200
Subject: [PATCH 0/4] ARM: dts: rockchip: add initial support for rk3288
 Chrome-devices
In-Reply-To: <1436574562-16308-1-git-send-email-heiko@sntech.de>
References: <1436574562-16308-1-git-send-email-heiko@sntech.de>
Message-ID: <2237472.zxKkR4oPTR@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Samstag, 11. Juli 2015, 02:29:18 schrieb Heiko Stuebner:
> This adds the basic support for two RK3288 Chrome-devices.
> Of course the internal display does not yet work, because we're
> missing the edp driver in mainline currently.
> But we're nevertheless able to boot to a rootfs on the devices.
> 
> 
> Alexandru M Stan (2):
>   ARM: dts: rockchip: add shared rk3288-veyron files
>   ARM: dts: rockchip: add veyron-jerry board
> 
> Chris Zhong (1):
>   ARM: dts: Add sbs-battery dts fragment used by chromebooks
> 
> Heiko Stuebner (1):
>   ARM: dts: rockchip: add Pinky board

applied these 4 with Dougs Acks/Reviews after addressing Dougs comments by
- removing /bits/ 8 from gpio-restart
- removing the bt_dev_wake pin for now
- removing dvs-pins from the rk808 node
- fixing missing newline in the pinky patch
