From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Fri, 18 Sep 2015 16:19:57 +0100
Subject: Recent GIC v1 patch
In-Reply-To: <20150918151418.4c0ed401@arm.com> (Marc Zyngier's message of
 "Fri, 18 Sep 2015 15:14:18 +0100")
References: <55FAE26A.9040609@free.fr> <55FAEB4D.30306@arm.com>
 <55FAF6E1.7020107@free.fr> <55FAFD3E.7010006@arm.com>
 <55FBD6F4.8030905@free.fr> <20150918120851.6f9fb306@arm.com>
 <yw1xbnczub0y.fsf@unicorn.mansr.com> <55FC18A4.2080205@free.fr>
 <20150918151418.4c0ed401@arm.com>
Message-ID: <yw1x7fnnu542.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Zyngier <marc.zyngier@arm.com> writes:

> On Fri, 18 Sep 2015 15:59:00 +0200
> Mason <slash.tmp@free.fr> wrote:
>
>> On 18/09/2015 15:12, M?ns Rullg?rd wrote:
>> 
>> > Marc Zyngier wrote:
>> > 
>> >> No idea so far. The only thing I can immediately spot is a missing pair
>> >> of chained_irq_{enter,exit} in tangox_irq_handler, but I can't imagine
>> >> this having a terminal effect on the system.
>> > 
>> > Fixed in the tangox tree on github.
>> 
>> Oh boy! Oh boy! Oh boy!
>> 
>> That did the trick. Just when I was about to give up...
>> 
>> Marc, I'm sending you an e-hug. Mans, you have my eternal gratitude.
>
> Thanks, but I prefer cheese! ;-)
>
> 	M.
> -- 
> Jazz is not dead. It just smells funny.

Smelly cheese?

-- 
M?ns Rullg?rd
mans at mansr.com
