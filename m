From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 08 Jul 2016 00:31:24 +0200
Subject: [PATCH v1 3/5] ARM: dts: rockchip: add eDP/panel display device
 nodes for rk3288-evb
In-Reply-To: <1467089478-18670-1-git-send-email-ykk@rock-chips.com>
References: <1467089288-18355-1-git-send-email-ykk@rock-chips.com>
 <1467089478-18670-1-git-send-email-ykk@rock-chips.com>
Message-ID: <35835280.FrP3zGa3K1@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 28. Juni 2016, 12:51:18 schrieb Yakir Yang:
> The default eDP panel on RK3288 EVB board is LG LP079QX1-SP0V TFT LCD,
> we haven't declared the panel regulator in the 'panel-simple' device
> node here, so the specific board like ACT8846 / RK8080 need to support
> the panel power supply.
> 
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>

applied, after reordering the entries to keep our alphabetical sorting.


Heiko
