From: davidb@codeaurora.org (David Brown)
Date: Sat, 6 Aug 2011 21:11:24 -0700
Subject: experience with the new arm-soc workflow (Was: Re:
	[Ksummit-2011-discuss] ARM Maintainers workshop at Kernel Summit) 2011
In-Reply-To: <CAHXqBF+BAdNo3NB9gk0o_aTHUxyQRHw_AvM5ok9zn2yk4NsRZw@mail.gmail.com>
References: <CACxGe6u3jrhnmL=QwCevm5ybgtGqdOzmGZpfve02M12e9v6pNQ@mail.gmail.com>
	<CAOesGMhgd9Grs7JErJ1pTY4fD_taX_YSpeKx_QS21dp2UN=vMQ@mail.gmail.com>
	<20110806212932.GT31521@pengutronix.de>
	<alpine.LFD.2.00.1108061742490.20358@xanadu.home>
	<CAHXqBF+BAdNo3NB9gk0o_aTHUxyQRHw_AvM5ok9zn2yk4NsRZw@mail.gmail.com>
Message-ID: <20110807041124.GA6410@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 07, 2011 at 12:13:48AM +0200, Micha? Miros?aw wrote:

> I, as another contributor, share Uwe's point of view. The problem with
> cleanups vs features is that either usually depends on the other.
> Fixes are a different beasts and they usually go in asynchronously
> (and quicker) to development changes. The split fixes/development
> works well in networking area (net and net-next trees).

Maybe we are thinking about two different kinds of cleanups.  Cleanups
that would be closely associated with a new feature do make sense to
me to keep together.  This is the kind of thing where code is cleaned
up in order to make it easier/cleaner to add the new code.  I don't
think this makes sense to have in another branch.

But, there is also a lot of code going on now that is just cleaning
things up, and it makes sense for this to be in a separate branch.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
