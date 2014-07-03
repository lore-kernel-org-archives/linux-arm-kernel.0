From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Thu, 03 Jul 2014 23:16:16 +0100
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <20140703173226.GC17372@arm.com> (Will Deacon's message of "Thu,
 3 Jul 2014 18:32:26 +0100")
References: <CAMbhsRSzDYqDnLbicYYNq+=J1N8hZ0fu-mik+UNLs0cBfUf8DA@mail.gmail.com>
 <CAOesGMh25XO=PYSSTbYkoVrQER=09mnKt68LMbLVT4+dBa716w@mail.gmail.com>
 <20140701234800.GA23577@sirena.org.uk>
 <20140702100133.GE18731@arm.com> <20140702163923.GJ410@sirena.org.uk>
 <20140702170141.GH24879@arm.com>
 <CACxGe6skyD-dNqR_XgqbWrwFsDs4Stwo81VQ4yviJMZK=kB8tA@mail.gmail.com>
 <20140703104135.GA28175@arm.com>
 <CACxGe6vmNamkAzvL8c5qaVEh9kvmTa=gEyr8KgBS1PW+KFc_=Q@mail.gmail.com>
 <20140703170558.GZ32514@n2100.arm.linux.org.uk>
 <20140703173226.GC17372@arm.com>
Message-ID: <yw1xoax6dr67.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon <will.deacon@arm.com> writes:

> On Thu, Jul 03, 2014 at 06:05:58PM +0100, Russell King - ARM Linux wrote:
>> On Thu, Jul 03, 2014 at 05:22:30PM +0100, Grant Likely wrote:
>> > So, no. I completely reject any notion that breaking existing apps is
>> > okay. If we're going to say that v8 still supports 32-bit apps, then
>> > it has to be all of v7, not just the 'good' bits. Nor do I think
>> > saying "it's just a bunch of games" justifies anything. We're kernel
>> > engineers. Applications are applications and we don't break userspace.
>> > Period.
>> 
>> +1 on all points above.  I'd go further - if we're going to say that v8
>> still supports 32-bit apps, that covers at least v6 *as well*.
>
> We've never pretended to support anything other than ARMv8 in the compat
> layer. uname even reports this in the machine name.
>
> If people are suddenly so concerned about *full* compatibility with an ARMv7
> kernel, that needs a lot more than just SWP emulation:
>
>   - Alignment fixups for ldm/stm

No ARM variant ever supported unaligned ldm/stm.

-- 
M?ns Rullg?rd
mans at mansr.com
