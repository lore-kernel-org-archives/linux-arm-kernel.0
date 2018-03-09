From: jeffy.chen@rock-chips.com (JeffyChen)
Date: Fri, 09 Mar 2018 16:45:48 +0800
Subject: [PATCH v4 0/4] Set name of regmap_config
In-Reply-To: <20180309081603.4u5pgwwsfxernodm@dell>
References: <20180309015146.8297-1-jeffy.chen@rock-chips.com>
 <20180309081603.4u5pgwwsfxernodm@dell>
Message-ID: <5AA249BC.6020705@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

Thanks for your reply.

On 03/09/2018 04:16 PM, Lee Jones wrote:
>> >
>> >Jeffy Chen (4):
>> >   mfd: syscon: Set name of regmap_config
>> >   rtc: at91sam9: Set name of regmap_config
>> >   clk: lpc32xx: Set name of regmap_config
>> >   ARM: rockchip: Set name of regmap_config
>> >
>> >  arch/arm/mach-rockchip/platsmp.c | 1 +
>> >  drivers/clk/nxp/clk-lpc32xx.c    | 1 +
>> >  drivers/mfd/syscon.c             | 1 +
> It's difficult to review, since we cannot see what's happening with
> the rest of the patch set.  Would you mind re-sending the whole set to
> all parties please?
sure, i can do that :)

>
