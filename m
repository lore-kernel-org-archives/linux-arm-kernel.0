From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 7 Feb 2014 13:32:38 +0100
Subject: [PATCH v2 6/6] cpu/idle.c: move to sched/idle.c
In-Reply-To: <alpine.LFD.2.11.1402071051140.1906@knanqh.ubzr>
References: <1391017513-12995-1-git-send-email-nicolas.pitre@linaro.org>
 <1391017513-12995-7-git-send-email-nicolas.pitre@linaro.org>
 <20140130152500.GB5002@laptop.programming.kicks-ass.net>
 <alpine.LFD.2.11.1401301102210.1652@knanqh.ubzr>
 <20140130162753.GF5002@laptop.programming.kicks-ass.net>
 <alpine.LFD.2.11.1402061152550.1906@knanqh.ubzr>
 <20140206164336.GU2936@laptop.programming.kicks-ass.net>
 <alpine.LFD.2.11.1402071051140.1906@knanqh.ubzr>
Message-ID: <20140207123238.GA9987@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 07, 2014 at 11:09:23AM +0000, Nicolas Pitre wrote:
> On Thu, 6 Feb 2014, Peter Zijlstra wrote:
> > tree, tree, what's in a word.
> 
> Something you may plant on a patch of grass?  "Merging" becomes a 
> strange concept in that context though.  :-)

I do know some farmers who splice trees thought :-)

> > Its in my patch stack yes. 
> 
> Quilt I suppose?? (yet another word.)

Yes, I'm one of the refugee Quilt users. Comes in handy when cold too
:-)

> > I should get some of that into tip I suppose, been side-tracked a bit 
> > this week. Sorry for the delay.
> 
> If you prefer we pile those patches (and future ones after revew) 
> ourselves just let me know.  Future patches are likely to be more 
> intimate with the scheduler so I just need to know who to upstream them 
> through afterwards.

Normally I get Ingo to pick up the queue 1-2 times a week so latency
shouldn't be too bad. But we just had the merge window and then I got
side-tracked rewriting all atomic implementations.

So usually submit patches against tip/master unless you know there's
other pending bits that conflict, in which case you can grab my queue on
top of tip/master -- but I try to make sure that's usually not needed.
