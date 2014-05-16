From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 16 May 2014 10:18:50 +0200
Subject: [PATCH RFC 00/11] Remove mach-kirkwood
In-Reply-To: <20140515230849.GS27822@titan.lakedaemon.net>
References: <1400163836-9831-1-git-send-email-andrew@lunn.ch>
 <8332148.Z1shujgC24@wuerfel> <20140515230849.GS27822@titan.lakedaemon.net>
Message-ID: <5375C9EA.3060307@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/05/2014 01:08, Jason Cooper wrote:
> On Thu, May 15, 2014 at 04:36:35PM +0200, Arnd Bergmann wrote:
>> On Thursday 15 May 2014 16:23:41 Andrew Lunn wrote:
>>> This is an RFC patchset which removes mach-kirkwood, now that kirkwood
>>> support has been converted to DT and lives in mach-mvebu.
>>>
>>> It is an RFC because some of the final conversion patches have not yet
>>> been accepted by maintainers, in particular:
>>>
>>> http://www.spinics.net/lists/arm-kernel/msg328068.html
>>>
>>> which needs to be accepted by the Sound/ASoC maintainer.
>>>
>>> Once the real patchset is posted, without the RFC status, we would
>>> prefer that each subsystem maintainer takes the relevent patches,
>>> rather than try to take them all through arm-soc.
>>
>> Very nice!
>>
>> We had a couple of conflicts in 3.15 between kirkwood and dove both
>> getting moved to multiplatform. Any idea how this can be done better
>> this time?
> 
> Yes, once the changes have matured in -next, I'll merge them into a
> single branch to pull instead of separately like I did before.
> 
>> There are three other series that may or may not make it into 3.16
>> and that will have conflicts with this one:
>>
>> - remove mv78xx0

Actually I planned to try to convert this to multiplatform
through mvebu. Based on the patches I already sent a few monthes ago
and on the work done by Thomas for orion5x. I have a slot to do
it on Tuesday, but I don't expect it was merged in 3.16.

>> - remove mach-dove
> 
> ? I haven't seen anything on these...
> 
>> - convert orion5x to multiplatform
> 
> I have this one already.
> 
>> If we can decide which ones we should have, we can make sure the
>> patches correctly build on top of one another or get merged into
>> one per subsystem.
> 
> hmmm, yes, if only we had some people assigned to do that. ;-)
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
