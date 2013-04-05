From: moore@free.fr (Chris Moore)
Date: Fri, 05 Apr 2013 07:14:17 +0200
Subject: [PATCH] ARM: kirkwood: DT board setup for CloudBox
In-Reply-To: <20130405011143.GX13280@titan.lakedaemon.net>
References: <20130329184109.GA16404@kw.sim.vm.gnt> <51568B89.1060009@free.fr>
 <20130401163316.GC16404@kw.sim.vm.gnt> <515A5BC6.5000007@free.fr>
 <20130402114535.GR13280@titan.lakedaemon.net>
 <20130402125408.GH16404@kw.sim.vm.gnt>
 <20130402172454.GT13280@titan.lakedaemon.net> <515D0776.7050208@free.fr>
 <20130404080058.GJ16404@kw.sim.vm.gnt> <20130404093435.GK16404@kw.sim.vm.gnt>
 <20130405011143.GX13280@titan.lakedaemon.net>
Message-ID: <515E5DA9.1000605@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 05/04/2013 03:11, Jason Cooper a ?crit :
> On Thu, Apr 04, 2013 at 11:34:35AM +0200, Simon Guinot wrote:
>>
...

>> Then we are back to the initial problem...
>>
>> Maybe we could append some suffixes based on the version:
>>
>> 1: cloudbox-v1
>> 2: cloudbox-v2
>>
>> Or better, suffix based on the other code names:
>>
>> 1: cloudbox-ns2mini
>> 2: cloudbox-familybox
>>
>> Or even let the things as they are:
>>
>> 1: netspace_v2_mini
>> 2: cloudbox
> In light of the above info, let's got with the third option.  If we
> discover a different LaCie Cloudbox board down the road, we can add an
> appropriately more specific compatible string to differentiate.  As you
> can tell, I'd prefer to have something more specific in the original
> commit, but we can only work with what we're given. :(
>

This is now OK with me.
However I would like to have a more precise description somewhere; 
probably either in the Kconfig or, if this is obsolescent, in whatever 
replaces it.
I think that someone grepping the kernel sources for the commercial name 
"CloudBox" should find both versions and be able to decide which one he has.

Cheers,
Chris
