From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Fri, 23 Nov 2018 15:42:24 +0100
Subject: [PATCH 4/6] clk: mvebu: ap806: Fix clock name for the cluster
In-Reply-To: <153980091588.5275.2414842812770832337@swboyd.mtv.corp.google.com>
 (Stephen Boyd's message of "Wed, 17 Oct 2018 11:28:35 -0700")
References: <20180922181709.13007-1-gregory.clement@bootlin.com>
 <20180922181709.13007-5-gregory.clement@bootlin.com>
 <153980091588.5275.2414842812770832337@swboyd.mtv.corp.google.com>
Message-ID: <87efbbq2i7.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,
 
 On mer., oct. 17 2018, Stephen Boyd <sboyd@kernel.org> wrote:

> Quoting Gregory CLEMENT (2018-09-22 11:17:07)
>> Actually, the clocks exposed for the cluster are not the CPU clocks, but
>> the PLL clock used as entry clock for the CPU clocks. The CPU clock will
>> be managed by a driver submitting in the following patches.
>> 
>> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>
> Does this need a fixes tag?

It doesn't fix a regression so I don't thing it needs a fixes tag.

Gregory

>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
