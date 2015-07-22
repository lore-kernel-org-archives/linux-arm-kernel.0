From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 22 Jul 2015 23:55:42 +0200
Subject: [PATCH v3 0/6] drm/rockchip: fixes and new features
In-Reply-To: <1437466807-13689-1-git-send-email-mark.yao@rock-chips.com>
References: <1437466807-13689-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <3417298.NC7okUxlpt@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 21. Juli 2015, 16:20:01 schrieb Mark Yao:
> This series patches are used for yuv image overlay display.
> 
> Rockchip vop support NV11, NV16, NV24 yuv format,
> and can scale the image scale 1/8 to 8.

I've tested this series on veyron-pinky on 4.2-rc3, as mentioned as response 
to patch 4/6, this actually brings back my x11 cursor that vanished after 4.2-
rc1 :-)


For the whole series
Tested-by: Heiko Stuebner <heiko@sntech.de>
