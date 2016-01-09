From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 09 Jan 2016 03:17:11 +0100
Subject: [PATCH v2 01/12] ARM: dts: rockchip: set the pinctrl default
 setting for rk3036 i2s
In-Reply-To: <1452155155-16232-2-git-send-email-wxt@rock-chips.com>
References: <1452155155-16232-1-git-send-email-wxt@rock-chips.com>
 <1452155155-16232-2-git-send-email-wxt@rock-chips.com>
Message-ID: <8406252.OUY4UcCHur@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 7. Januar 2016, 16:25:44 schrieb Caesar Wang:
> Sometime will hang if you set the i2s pinctrl as the none setting.
> Let's set the pinctrl as the default setting to enable the gpio up/down.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>

applied to my dts branch for 4.6
