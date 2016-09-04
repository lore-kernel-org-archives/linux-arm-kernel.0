From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 05 Sep 2016 00:16:00 +0200
Subject: [PATCH] arm64: dts: rockchip: add the tcpc for rk3399 power domain
In-Reply-To: <1472848746-30135-1-git-send-email-wxt@rock-chips.com>
References: <1472848746-30135-1-git-send-email-wxt@rock-chips.com>
Message-ID: <3920881.7AifuoZ7Y0@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Samstag, 3. September 2016, 04:39:06 CEST schrieb Caesar Wang:
> The tcpc is the Type C Port Controller and Type C Port Delivery (tcpd)
> is part of it, we haven't used them now, add it to save power consumption.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>

applied to my dts64 branch for 4.9, after checking in the TRM that the tcpc 
really doesn't seem to have a matching qos block.


Thanks
Heiko
