From: megous@megous.com (=?UTF-8?Q?Ond=c5=99ej_Jirman?=)
Date: Sat, 25 Jun 2016 17:23:12 +0200
Subject: [PATCH v2 01/14] ARM: clk: sunxi: Add driver for the H3 THS clock
In-Reply-To: <20160625071338.GC4000@lukather>
References: <20160625034511.7966-1-megous@megous.com>
 <20160625034511.7966-2-megous@megous.com> <20160625071338.GC4000@lukather>
Message-ID: <6a37450f-35fe-3296-da4b-10f7d645e2b9@megous.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

I try to base everything on the torvalds's kernel.

I did notice the patches. Is there some main git tree/branch where this
work is tracked in? I'd gladly use it.

Also there's a PLL1 rate application patch, that would need to be ported
to the new CCU code, in the case I would use it as a base for this work.
Given that the new CCU code is your work and it's fresh in your mind, do
you have suggestion how to approach it?

It is [PATCH v2 06/14] in this series.

regards,
  o.

On 25.6.2016 09:13, Maxime Ripard wrote:
> Hi,
> 
> On Sat, Jun 25, 2016 at 05:44:58AM +0200, megous at megous.com wrote:
>> From: Josef Gajdusek <atx@atx.name>
>>
>> This patch adds a driver for the THS clock which is present on the
>> Allwinner H3.
>>
>> Signed-off-by: Josef Gajdusek <atx@atx.name>
> 
> You might not have noticed, but we are currently rewriting the whole
> clock support for the Allwinner SoCs, targetting the H3 as the first
> SoC to use it.
> 
> There's already some support for the H3 THS clock, so please use that
> instead.
> 
> Thanks!
> Maxime
> 
