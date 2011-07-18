From: BJulin@clarku.edu (Brian Julin)
Date: Mon, 18 Jul 2011 19:54:36 -0400
Subject: [PATCH] freshen up mm/proc-arm946.S
In-Reply-To: <CA+wbFdeYFQP6GC2zzPW4EPdG82UECT8Fo1FxxHfYq0Rp2tu7qg@mail.gmail.com>
References: <5A630F46702DD1498FFD48394B4A664CB39A93520F@john.ad.clarku.edu>,
	<CA+wbFdeYFQP6GC2zzPW4EPdG82UECT8Fo1FxxHfYq0Rp2tu7qg@mail.gmail.com>
Message-ID: <5A630F46702DD1498FFD48394B4A664CB39A935210@john.ad.clarku.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Monday, July 18, 2011 6:32 AM,  Dave Martin [dave.martin at linaro.org] wrote:
>  If you've not already done so, I suggest you check that your patch
> applies against Russell's devel-stable branch.  There has been a bit
> of refactoring of some of these files, but I think your patch will
> stlil apply (unfortunately I'm not in a position to test it right
> now).
>
> The patch looks at least possibly correct (I'm not able to check that
> either, today...)

Hunk #1 succeeded at 411 (offset -36 lines).
Hunk #2 succeeded at 420 (offset -36 lines).

Good enough?  The "linux-next" tree on kernel.org seems to have the patched from 
arm:stable that affect this file, and from the looks of things both hunks are still needed 
and do not conflict with the renovations.

So what now?  The last time I submitted a patch was over a decade ago... gerg mentioned
something about "rmk's patch system"?

--
Brian
