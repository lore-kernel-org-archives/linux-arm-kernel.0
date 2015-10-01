From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 01 Oct 2015 10:12:34 +0200
Subject: [PATCH v3 5/8] clk: rockchip: add new clock type and controller
 for rk3036
In-Reply-To: <1443492833-15630-6-git-send-email-zhengxing@rock-chips.com>
References: <1443492833-15630-1-git-send-email-zhengxing@rock-chips.com>
 <1443492833-15630-6-git-send-email-zhengxing@rock-chips.com>
Message-ID: <17410513.afcQr96dHz@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 29. September 2015, 10:13:50 schrieb Xing Zheng:
> The rk3036's pll and clock are different with base on the rk3066(rk3188,
> rk3288, rk3368 use it), there are different adjust foctors and control
> registers, so these should be independent and separate from the series
> of rk3066s.

subject should probably be like
clk: rockchip: add new pll-type for rk3036 and similar socs


And the general handling should probably be implemented similar to the example 
I posted in the v2 thread yesterday. [of course folded in and not as a 
separate patch ;-) ]


Heiko
