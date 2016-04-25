From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 25 Apr 2016 09:57:56 +0200
Subject: [RESEND PATCH 8/8] arm64: dts: rockchip: move the rk3368 thermal
 data into rk3368.dtsi
In-Reply-To: <1461319374-10024-9-git-send-email-wxt@rock-chips.com>
References: <1461319374-10024-1-git-send-email-wxt@rock-chips.com>
 <1461319374-10024-9-git-send-email-wxt@rock-chips.com>
Message-ID: <1669183.h99KHesK9J@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 22. April 2016, 18:02:54 schrieb Caesar Wang:
> In order to be standard to manage for rockchip SoCs,  move the thermal
> data into rk3368 dtsi, we needn't to add a new file for thermal.
> 
> Fixes commit f990238f859e
> ("arm64: dts: rockchip: Add main thermal info to rk3368.dtsi")
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Heiko Stuebner <heiko@sntech.de>

completely independent of the thermal changes above, so I've picked this one 
up for 4.7


Thanks
Heiko
