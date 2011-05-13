From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 13 May 2011 18:36:00 +0200
Subject: [PATCH V2] usb/gadget: at91sam9g20 fix end point max packet size
In-Reply-To: <20110513162054.GC2728@suse.de>
References: <1305042888-19401-1-git-send-email-plagnioj@jcrosoft.com>	<1305298982-5789-1-git-send-email-plagnioj@jcrosoft.com>
	<20110513162054.GC2728@suse.de>
Message-ID: <4DCD5DF0.8060406@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 13/05/2011 18:20, Greg KH :
> On Fri, May 13, 2011 at 05:03:02PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
>> on 9g20 they are the same as the 9260
>>
>> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> ---
>> Resent upon Greg's request.
>> Based on current linux-next.
>> Applies cleanly on current linus' tree (2.6.39-rc7+)
>>
>> BTW, can we imagine it going to mainline before .39-final in a "fixes" pull
>> request to Linus from a at91 tree?
> 
> No, as I don't think this is a bug-fix-only-for-regression, is it?

Not a regression, but a
oh-my-god-how-it-has-been-there-for-such-a-long-time type of bug.

> It looks to be a "fix for new hardware" type thing, right?

Hardware has been merged in kernel for a pretty long time now... But
anyway, I fully understand: this bug has been sitting in the dark for a
handful of kernel revision now, so it can wait for .40...

> And is this really the correct way to do this for the .40 kernel, which
> is where I would be queueing this up for?

Right. Let's queue it for .40.

Bye,
-- 
Nicolas Ferre
