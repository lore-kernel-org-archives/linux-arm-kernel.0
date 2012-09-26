From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 26 Sep 2012 18:40:39 +0200
Subject: [PATCH V5] Add support for Aurora L2 Cache Controller
In-Reply-To: <20120926162407.GN5469@titan.lakedaemon.net>
References: <1348675370-16359-1-git-send-email-gregory.clement@free-electrons.com>
 <5063286C.9070502@free-electrons.com>
 <20120926162407.GN5469@titan.lakedaemon.net>
Message-ID: <50633007.7050808@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/26/2012 06:24 PM, Jason Cooper wrote:
> On Wed, Sep 26, 2012 at 06:08:12PM +0200, Gregory CLEMENT wrote:
>>> Changelog:
>>> V4 -> V5:
>>> - Rebased L2 pach set onto v3.6-rc7.
>>> - The header file cache-aurora-l2.h was co-located with its only user:
>>>   moved from arch/arm/include/asm/hardware/ to arch/arm/mm/.
>>> - Removed additional unnecessary blank lines in cache-l2x0.c.
>>>
>> Russell,
>>
>> will you take the all series from the git repository ? As the
>> last patches have been already acked-by Arnd and were initially pulled
>> by Jason Cooper, I think there should be no problem to get the whole
>> series.
>>
>> Now if you only want to take the first three patches, will you pull
>> them from the git repository or do you prefer that I submit them
>> through your patch system?
> 
> Russell,
> 
> If you're ok with it, I can take the whole series (incl 1,2,3) through
> my tree.  Or, split it up as we did before (arch/arm/mm changes through
> you, all else through us).
> 
> Gregory,
> 
> I'm inclined to make this v3.8 material, especially if pushing it
> through two different trees.  Do you have any objection?

Well I have pushed this series a long time ago and I have hopped it
would have been part of the v3.7.

The only issue I found when I tried to merge this branch with the
for-next of arm-soc  was a very trivial conflict in
arch/arm/mach-mvebu/Kconfig.

> 
> thx,
> 
> Jason.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
