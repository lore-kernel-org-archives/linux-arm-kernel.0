From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 31 Jan 2013 10:39:59 -0700
Subject: [PATCHv5 00/16] Unify arm_generic and arch_timer drivers
In-Reply-To: <1359634539-9580-1-git-send-email-mark.rutland@arm.com>
References: <1359634539-9580-1-git-send-email-mark.rutland@arm.com>
Message-ID: <510AAC6F.90302@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/31/2013 05:15 AM, Mark Rutland wrote:
> This is an updated version of v4 of the series I posted 2 weeks ago [1].
> 
> The only change is the last two patches, moving over to always using the
> virtual counters. I've left these as separate patches rather than
> folding them in to allow them to be reviewed more easily.
> 
> I've tested the series on a TC2 and an AArch64 model, and I'm happy that
> it all works.
> 
> Stephen, Thomas:
> 
> I've not folded the CLOCKSOURCE_OF_DECLARE patch as it's unclear what
> path everything is going to take, and I don't a have a tree with
> Stephen's patch that I can base on.

I'm pretty sure it'll go through arm-soc's timer/cleanup branch. At the
very least, it'd have to go through some tree based on that...

> There's already a dependency on the timer broadcast rework, and adding
> more branches to the mix is going to get messy. I can take the version
> with ifdefs under the assumption we remove them in a later patch once
> Stephen's patch is in. Does that sound ok?

Just one more simple merge:-)

But yet, it's a simple cleanup to do later, so I have no problem with that.
