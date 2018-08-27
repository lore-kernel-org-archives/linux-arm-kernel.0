From: icenowy@aosc.io (Icenowy Zheng)
Date: Tue, 28 Aug 2018 07:08:22 +0800
Subject: [PATCH] clk: sunxi-ng: sun50i: h6: Add 2x fixed post-divider to
 MMC module clocks
In-Reply-To: <153540143478.129321.8502068006504989469@swboyd.mtv.corp.google.com>
References: <20180820134013.16527-1-icenowy@aosc.io>
 <153540143478.129321.8502068006504989469@swboyd.mtv.corp.google.com>
Message-ID: <D5B9F1CA-6108-41EB-9D6C-56883C79F361@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2018?8?28? GMT+08:00 ??4:23:54, Stephen Boyd <sboyd@kernel.org> ??:
>Quoting Icenowy Zheng (2018-08-20 06:40:13)
>> On the H6, the MMC module clocks are fixed in the new timing mode,
>> i.e. they do not have a bit to select the mode. These clocks have
>> a 2x divider somewhere between the clock and the MMC module.
>> 
>> To be consistent with other SoCs supporting the new timing mode,
>> we model the 2x divider as a fixed post-divider on the MMC module
>> clocks.
>> 
>> This patch adds the post-dividers to the MMC clocks, following the
>> approach on A64.
>> 
>> Fixes: 542353ea ("clk: sunxi-ng: add support for the Allwinner H6
>CCU")
>
>This commit doesn't exist. Did you mean:
>
>524353ea48
>
>instead?

Yes, it is.

Thanks!

>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel at lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
