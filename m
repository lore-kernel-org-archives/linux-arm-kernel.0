From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 14 May 2016 13:57:12 +0200
Subject: [PATCH] ARM64: dts: rockchip: assign default rates for core
 rk3399 clocks
In-Reply-To: <1463172618-96001-1-git-send-email-briannorris@chromium.org>
References: <1463172618-96001-1-git-send-email-briannorris@chromium.org>
Message-ID: <25672526.OH6Oxq7zkd@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 13. Mai 2016, 13:50:18 schrieb Brian Norris:
> From: Xing Zheng <zhengxing@rock-chips.com>
> 
> These clocks are all core clocks used by many blocks/peripherals, many
> of whose drivers don't set their clock rates at all. Let's assign
> reasonable default clock rates for these core clocks, so that these
> peripherals get something reasonable by default, and also so that if
> child devices want to select a clock rate themselves, their muxes have
> some reasonable parent clock rates to branch off of (rather than just
> the boot-time defaults).
> 
> This helps the eMMC PHY, for one, to get a reasonable ACLK rate.
> 
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

applied for 4.8 with Doug's review-tag (after making the ARM64 lower-case)
