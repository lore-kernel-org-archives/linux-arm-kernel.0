From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 22 Jul 2017 22:47:35 +0200
Subject: [PATCH] ARM: dts: enable sdmmc for rockchip rv1108 evb
In-Reply-To: <1500545621-20746-1-git-send-email-andy.yan@rock-chips.com>
References: <1500545621-20746-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <14029252.zVFmYa7h66@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 20. Juli 2017, 18:13:41 CEST schrieb Andy Yan:
> Enable sdmmc on rv1108 evaluation board. Also
> add pinctrl for sdmmc controller.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

applied for 4.14, after adapting the subject to
	ARM: dts: rockchip: enable sdmmc for rv1108 evb

and moving the pinctrl properties down some lines


Heiko
