From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 22 May 2017 17:02:23 +0200
Subject: [PATCH] arm64: dts: rockchip: update cpu opp table for rk3399 op1
In-Reply-To: <CAJrj+DPzj0hieOHHpoxL4_uPUyaOa7LADJw+4_82VDZiPKxy1g@mail.gmail.com>
References: <1493014730-9670-1-git-send-email-wxt@rock-chips.com>
 <3119382.DFiP2J6FnE@diego>
 <CAJrj+DPzj0hieOHHpoxL4_uPUyaOa7LADJw+4_82VDZiPKxy1g@mail.gmail.com>
Message-ID: <2392465.b79CVULcOX@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eddie, Caesar,

Am Montag, 24. April 2017, 18:29:26 CEST schrieb Eddie Cai:
> Hi Heiko
> 
> 2017-04-24 17:15 GMT+08:00 Heiko St?bner <heiko@sntech.de>:
> > Am Montag, 24. April 2017, 16:49:08 CEST schrieb Caesar Wang:
> >> ? 2017?04?24? 16:26, Heiko St?bner ??:
> >> > Hi Caesar,
> >> >
> >> > Am Montag, 24. April 2017, 14:18:50 CEST schrieb Caesar Wang:
> >> >> Update the cpu opp table for rk3399 op1.
> >> >
> >> > Ideally this should contain something about the "why".
> >> > Are these new voltage settings safer to operate under?
> >>
> >> The before opp table is for earlier batch of rk3399 SoCs,  that's no
> >> enough for the current and
> >> newer batch of rk3399 op1. In order to suit for the rk3399 op1, we need
> >> to little voltages changed.
> >
> > just to make sure, this is also safe for all the non-chromebook rk3399 socs
> > (like the firefly and tv-boxes, etc), right?
> This is only for op1. other 3399s should have a different opp table

digging this up, as I'm right now working on a rk3399-firefly, could you
provide the correct opp tables for the available rk3399 variants please?

I.e. generally safe opps for boards like the firefly and the special ones
for op1-based devices?


Thanks
Heiko
