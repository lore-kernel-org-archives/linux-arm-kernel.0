From: Ying.Liu@freescale.com (Liu Ying)
Date: Wed, 21 Aug 2013 12:12:19 +0800
Subject: [PATCH 0/3] refactor some ldb related clocks
In-Reply-To: <20130821015939.GD30533@S2101-09.ap.freescale.net>
References: <1376987932-5540-1-git-send-email-Ying.Liu@freescale.com>
 <1376991823.4000.22.camel@pizza.hi.pengutronix.de>
 <52134030.4030502@freescale.com>
 <20130821015939.GD30533@S2101-09.ap.freescale.net>
Message-ID: <52143E23.9080203@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/21/2013 09:59 AM, Shawn Guo wrote:
> Hi Ying,
> 
> On Tue, Aug 20, 2013 at 06:08:48PM +0800, Liu Ying wrote:
>>> While I admit to having introduced the combination of 1/3.5 fixed
>>> divider and configurable 1/1,1/2 divder clocks to describe this
>>> fractional divider for the reasons you state, I think the correct
>>> solution would be to improve the table divider to support fractional
>>> values and get rid of the virtual ldb_di<n>_div_3_5 clocks, not
>>> introduce more virtual clocks.
>>
>> Yes, it's good to support fractional values for the table divider(not sure if there is any plan for this).
>> I see there is something similar in 'include/linux/sh_clk.h'.
> 
> Yeah, I agree with Philipp on improving table divider to support
> fractional values.  Would you like to work on that?
> 
> Shawn
> 

I don't have a plan to work on that now.

Liu Ying
