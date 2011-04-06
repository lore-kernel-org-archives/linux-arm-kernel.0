From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Wed, 06 Apr 2011 12:25:28 +0300
Subject: [PATCH 00/34] Make kernel build deterministic
In-Reply-To: <4D9C2D56.70700@suse.cz>
References: <1302015561-21047-1-git-send-email-mmarek@suse.cz>
	<20110405154918.GA31337@suse.de> <1302031447.2608.41.camel@koala>
	<4D9C2D56.70700@suse.cz>
Message-ID: <1302081928.2742.40.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-04-06 at 11:07 +0200, Michal Marek wrote:
> > So additionally, I'd suggest:
> > 1. Instrument checkpatch.pl and make it err or warn on timestamps.
> 
> This is patch 34/34 in this series: https://lkml.org/lkml/2011/4/5/198

Yeah, great, did not notice, thanks!

> > 2. Probably instrument linux-next to rise a warning when people break
> >    this.
> 
> I'm not sure if Stephen has that much spare time, and I don't think it
> is necessary. I think the checkpatch check is sufficient and I'll check
> myself occasionally.

Yes, that's fine, I just wanted to speak this out - there is a
probability that someone gets excited and creates some instrumentation
to kbuild to automatically detect bad things and then Stephen could
easily use that.

WRT "not necessary" - well, I think it is always better to cut bad
things before they are merged, rather than afterwards.

But anyway, let's forget about this.

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
