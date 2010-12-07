From: shawn.gsc@gmail.com (Shawn Guo)
Date: Tue, 7 Dec 2010 21:53:16 +0800
Subject: [PATCH 09/15] ARM: mxs: Add clock support
In-Reply-To: <20101207133322.GH21020@pengutronix.de>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1290754154-9428-10-git-send-email-shawn.guo@freescale.com>
	<20101130163922.GT20449@pengutronix.de>
	<AANLkTi=OTPd6wJ0hHO8jnO5NVC9f2ZpRDMeC7zWJwObG@mail.gmail.com>
	<20101207133322.GH21020@pengutronix.de>
Message-ID: <AANLkTima1HNU1UuGc4TJ1hz7Py0HbWy=JtVJ8+eJREDj@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

2010/12/7 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hello Shawn,
>
>> > Hmm, I would have used an approach that is quickly switchable to the
>> > generic clock stuff posted a few times here. ?But probably already too
>> > late. ?So it's up to you to decide when to switch (or if at all).
>> >
>> I suppose you are talking about the common struct clk patch from
>> Jeremy Kerr. ?Since mxs is closely tracking mxc, I would switch mxs
>> only mxc is switched.
> I want mxc switched sooner rather than later.
>
> If you ask me, don't stop to be inovative because of tracking mxc which
> supports many machines and so isn't that flexible as a new machine
> support.
>
OK.  I will try to switch once Jeremy's bits get merged.  But can we
pick the current implementation on imx tree for now, and then switch
based off imx tree later?

-- 
Regards,
Shawn
