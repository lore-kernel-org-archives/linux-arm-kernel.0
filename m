From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 30 Mar 2015 15:29:41 +0200
Subject: [PATCH 0/3] Add DT support for netxbig LEDs
In-Reply-To: <20150330132240.GB8688@io.lakedaemon.net>
References: <1424703861-20903-1-git-send-email-simon.guinot@sequanux.org>
 <20150309094107.GL1509@kw.sim.vm.gnt> <5506FE46.4000405@free-electrons.com>
 <20150330083040.GY1509@kw.sim.vm.gnt> <20150330123008.GC17650@lunn.ch>
 <20150330132240.GB8688@io.lakedaemon.net>
Message-ID: <55194FC5.6080902@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,
[...]

>>> Hi Gregory, Andrew and Jason,
>>>
>>> This patch set seems stuck. I believe that Bryan is probably too busy to
>>> handle it...
>>>
>>> Is that possible to merge it via the mvebu tree ? Since only some LaCie
>>> boards are impacted, I think it could make sense.
>>
>> Hi Simon
>>
>> Hard one. I also have a driver stuck in led limbo.
>>
>> Last time we took a fix via mvebu, it all went messy at the last
>> minute. We made it very clear to Bryon we planned to take a patch via
>> mvebu, we had queued it via mvebu, we had sent a pull request to
>> arm-soc, all with no reply from Bryon. Only at the last minute did he
>> jump in, pull it himself and send it to Linus. That caused Olof all
>> sorts of problems with his tree.
> 
> It's also good to keep in mind the workflow of driver maintainers who push
> directly to Linus.  They send PRs during the merge window, and don't
> necessarily spend too much time in -next.  Which means, if they have good
> filters running on lkml, they just sit down a week or so before the merge
> window and apply everything they have pending.
> 
> For those of us who are feeding arm-soc, and are accustomed to getting things
> in early, this can be nerve-wracking.
> 
> Brian has demonstrated that he does pick things up and get them merged.  We
> just need to make sure that what he picks up is well tested and reviewed when
> he gets to it.  Since there won't be time for another revision before the merge
> window.  But hey, that's what -rc's are for.  :-P
> 

At least what I can do is creating a led branch and merged it in the mvebu/for-next
branch. It will allow us to be more confident for the merge window.

Thanks,

Gregory


>> To stop that happening again, i think we need an Acked-by from Bryan.
> 
> I agree.





> 
> thx,
> 
> Jason.
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
