From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 11 Dec 2015 14:04:29 +0100
Subject: [PATCH 1/2] arm64: dts: rockchip: change the correct voltage
 range for rk3368 evb board
In-Reply-To: <1449054741-25354-1-git-send-email-wxt@rock-chips.com>
References: <1449054741-25354-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1606584.VJKYfIuzKa@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Caesar,

Am Mittwoch, 2. Dezember 2015, 19:12:20 schrieb Caesar Wang:
> In general, the logic voltage is affected by ddr frequency factors.
> We should fix the correct voltage range since assuemd that we have the
> ddr frequency driver in mainline.
> 
> AFAIK, the 1.8v voltage is used by the SD3.0 card.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>

applied both patches to the 32 and 64 bit dts branches for 4.5


Thanks
Heiko
