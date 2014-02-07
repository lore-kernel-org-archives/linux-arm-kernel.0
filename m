From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 7 Feb 2014 11:09:23 +0000 (GMT)
Subject: [PATCH v2 6/6] cpu/idle.c: move to sched/idle.c
In-Reply-To: <20140206164336.GU2936@laptop.programming.kicks-ass.net>
References: <1391017513-12995-1-git-send-email-nicolas.pitre@linaro.org>
 <1391017513-12995-7-git-send-email-nicolas.pitre@linaro.org>
 <20140130152500.GB5002@laptop.programming.kicks-ass.net>
 <alpine.LFD.2.11.1401301102210.1652@knanqh.ubzr>
 <20140130162753.GF5002@laptop.programming.kicks-ass.net>
 <alpine.LFD.2.11.1402061152550.1906@knanqh.ubzr>
 <20140206164336.GU2936@laptop.programming.kicks-ass.net>
Message-ID: <alpine.LFD.2.11.1402071051140.1906@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 6 Feb 2014, Peter Zijlstra wrote:

> On Thu, Feb 06, 2014 at 02:09:59PM +0000, Nicolas Pitre wrote:
> > Hi Peter,
> > 
> > Did you merge those patches in your tree? 
> 
> tree, tree, what's in a word.

Something you may plant on a patch of grass?  "Merging" becomes a 
strange concept in that context though.  :-)

> Its in my patch stack yes. 

Quilt I suppose?? (yet another word.)

> I should get some of that into tip I suppose, been side-tracked a bit 
> this week. Sorry for the delay.

If you prefer we pile those patches (and future ones after revew) 
ourselves just let me know.  Future patches are likely to be more 
intimate with the scheduler so I just need to know who to upstream them 
through afterwards.


Nicolas
