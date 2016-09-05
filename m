From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 05 Sep 2016 11:12:49 +0200
Subject: [PATCH 2/4] ARM: dts: rockchip: fix i2c address L3G4200D on
 PopMetal-RK3288 board
In-Reply-To: <1472978067-868-1-git-send-email-andy.yan@rock-chips.com>
References: <1472977937-758-1-git-send-email-andy.yan@rock-chips.com>
 <1472978067-868-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <2908713.CWeP2vUbBj@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag, 4. September 2016, 16:34:27 CEST schrieb Andy Yan:
> The i2c address of the three-axis digital gyroscope L3G4200D should be
> 0x69 according to hardware design.
> Also add power supply reference for L3G3200D and the 3-axis Electronic
> Compass AK8963.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

I've split this into two patches:
ARM: dts: rockchip: fix L3G4200D i2c address on PopMetal-RK3288 board
ARM: dts: rockchip: Add sensor-supplies on PopMetal-RK3288 board
and applied them to my dts32 branch for 4.9

Please don't mix multiple changes into one patch in the future :-)


Thanks
Heiko
