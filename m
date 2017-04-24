From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 24 Apr 2017 11:15:48 +0200
Subject: [PATCH] arm64: dts: rockchip: update cpu opp table for rk3399 op1
In-Reply-To: <f4c389af-5b1f-9197-0df4-f8407ed8622a@rock-chips.com>
References: <1493014730-9670-1-git-send-email-wxt@rock-chips.com>
 <2250946.xrPjMl5Kf1@diego>
 <f4c389af-5b1f-9197-0df4-f8407ed8622a@rock-chips.com>
Message-ID: <3119382.DFiP2J6FnE@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 24. April 2017, 16:49:08 CEST schrieb Caesar Wang:
> ? 2017?04?24? 16:26, Heiko St?bner ??:
> > Hi Caesar,
> > 
> > Am Montag, 24. April 2017, 14:18:50 CEST schrieb Caesar Wang:
> >> Update the cpu opp table for rk3399 op1.
> > 
> > Ideally this should contain something about the "why".
> > Are these new voltage settings safer to operate under?
> 
> The before opp table is for earlier batch of rk3399 SoCs,  that's no
> enough for the current and
> newer batch of rk3399 op1. In order to suit for the rk3399 op1, we need
> to little voltages changed.

just to make sure, this is also safe for all the non-chromebook rk3399 socs 
(like the firefly and tv-boxes, etc), right?


Thanks
Heiko
