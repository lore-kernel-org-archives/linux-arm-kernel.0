From: zhengxing@rock-chips.com (zhengxing)
Date: Thu, 1 Oct 2015 16:46:21 +0800
Subject: [PATCH v3 5/8] clk: rockchip: add new clock type and controller
 for rk3036
In-Reply-To: <17410513.afcQr96dHz@diego>
References: <1443492833-15630-1-git-send-email-zhengxing@rock-chips.com>
 <1443492833-15630-6-git-send-email-zhengxing@rock-chips.com>
 <17410513.afcQr96dHz@diego>
Message-ID: <39D164F7-3461-42FE-8D5D-B30756C86DD8@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Heiko,

???? iPad
> ? 2015?10?1??16:12?Heiko St?bner <heiko@sntech.de> ???
> 
> Am Dienstag, 29. September 2015, 10:13:50 schrieb Xing Zheng:
>> The rk3036's pll and clock are different with base on the rk3066(rk3188,
>> rk3288, rk3368 use it), there are different adjust foctors and control
>> registers, so these should be independent and separate from the series
>> of rk3066s.
> 
> subject should probably be like
> clk: rockchip: add new pll-type for rk3036 and similar socs
OK.
> 
> And the general handling should probably be implemented similar to the example 
> I posted in the v2 thread yesterday. [of course folded in and not as a 
> separate patch ;-) ]
> 
> Heiko
> 
OK, because I just received and saw this patch, and I will test and update it into next version patchset.


Thank you. :)
