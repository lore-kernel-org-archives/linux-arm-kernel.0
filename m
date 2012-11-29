From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 29 Nov 2012 11:39:56 +0000
Subject: vexpress compilation error in next-20121127
In-Reply-To: <50B679C9.2010808@broadcom.com>
References: <50B56601.5010305@broadcom.com>
 <1354106164.2987.21.camel@hornet> <50B679C9.2010808@broadcom.com>
Message-ID: <1354189196.2987.59.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-11-28 at 20:53 +0000, Markus Mayer wrote:
> What I am really concerned about is an arm-soc branch that has commit 
> 8ac49e0485 in it 
> (http://git.kernel.org/?p=linux/kernel/git/arm/arm-soc.git;a=commit;h=8ac49e0485bb79223a111b366a3b1f5ec9148729). 
> That commit seems to be in next/soc as well as for-next. Therefore, 
> either one might serve my purpose. I am able to build for-next, but 
> cannot build next/soc due to the above problem.
> 
> Is there a quick way to describe the difference between these two 
> branches? I am okay to use for-next rather than next/soc, but I would 
> like to know what the difference between the two.

Those are questions to Arnd and Olof, really, but _as far as I
understand_ theirs workflow, they keep pull topic branches from
developers into the respective "next" topic branches (ie. both
vexpress/soc and broadcom/soc got into next/soc), then all the topic
branches are merged into general for-next (so both next/soc and
next/drivers - amongst others - are there).

>Also, is it okay for one of the two branches to temporarily not build 
> (as is currently the case with next/soc)?

This is a policy question, again for Arnd and Olof. In my case I had a
long series of changes with internal dependencies and they asked me to
break it into topic branches. Maybe I could have done better job with
that, but other approach would have meant merge conflicts.

Pawe?
