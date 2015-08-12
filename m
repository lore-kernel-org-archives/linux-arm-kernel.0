From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 12 Aug 2015 14:48:03 +0530
Subject: [PATCH] thermal: cpu_cooling: fix lockdep problems in cpu_cooling
In-Reply-To: <20150812090811.GI7557@n2100.arm.linux.org.uk>
References: <20150812073530.GA16445@linux>
 <E1ZPQfV-0005nb-DN@rmk-PC.arm.linux.org.uk>
 <20150812081142.GB16445@linux>
 <20150812090811.GI7557@n2100.arm.linux.org.uk>
Message-ID: <20150812091803.GG16445@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12-08-15, 10:08, Russell King - ARM Linux wrote:
> Possibly, had the code previously been like that.  See:
> 
> commit 2479bb6443d6a793f896219a34bfab0cc410f0b4
> Author: Viresh Kumar <viresh.kumar@linaro.org>
> Date:   Thu Dec 4 09:42:04 2014 +0530
> 
> which post-dates this patch, and removes this "style" in favour of using
> the broken list mechanism.

Just to make sure I understand it properly, do you want to say that I
added 2479bb6 patch after you reported this problem & your patch?

If yes, then I don't see how my patch came after yours. Mine was
written on 4/Dec/2014 and committed on 8/Dec/2014 and you first
reported the problem on 14/Dec/2014.

> Frankly... you don't have a leg to stand on

I can accept that :)

> because _you_ knew about this problem, and you saw my patch.  So removing
> something that my patch to fix a serious bug relied upon...

I don't think I removed that stuff after your patch.

> You know what?  At this point, I'm just not going to bother.  You fix
> this lockdep problem, I'm obviously useless at kernel stuff.

Okay, leave it on me. I will re-circulate your patch.

-- 
viresh
