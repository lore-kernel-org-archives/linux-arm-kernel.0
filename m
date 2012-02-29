From: b-cousson@ti.com (Cousson, Benoit)
Date: Wed, 29 Feb 2012 23:39:27 +0100
Subject: [PATCH-V1] arm/dts: Add support for TI OMAP3 EVM board
In-Reply-To: <20120229223114.GS18901@atomide.com>
References: <1324019153-13316-1-git-send-email-hvaibhav@ti.com>
 <79CD15C6BA57404B839C016229A409A80719AC@DBDE01.ent.ti.com>
 <20120229223114.GS18901@atomide.com>
Message-ID: <4F4EA91F.1030305@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/29/2012 11:31 PM, Tony Lindgren wrote:
> * Hiremath, Vaibhav<hvaibhav@ti.com>  [120105 02:46]:
...
>> Can this merged? OR anybody has any comments here?
>
> For reference, looks like this one is queued up as
> commit f0e15e2b0c6b3e89daade25a1e9a2d80136c14c3.

Yes, it is, I included it in my DTS pull-request because it was the only 
one with Grant's ack.

I have the whole series ready to be pulled but was waiting for DT 
maintainers acked-by.

I still have these four ones in my branch.

d5c9442 arm/dts: Add support for TI AM3517/05 EVM board
3b5fa9a arm/dts: omap3-evm: Add i2c and twl4030 support
7f4ca5f arm/dts: Add support for TI AM335x EVM board
d0c3aca ARM: OMAP2+: board-generic: Add DT support for AM33xx devices

In fact the board one already has the proper ack, only the DTS are 
missing it.

Regards,
Benoit
