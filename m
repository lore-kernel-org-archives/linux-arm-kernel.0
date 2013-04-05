From: olof@lixom.net (Olof Johansson)
Date: Fri, 5 Apr 2013 14:07:44 -0700
Subject: [GIT PULL] Multi Cluster Power Management infrastructure
In-Reply-To: <201304052233.25630.arnd@arndb.de>
References: <alpine.LFD.2.03.1303251219530.1372@syhkavp.arg>
 <alpine.LFD.2.03.1304042138160.1171@syhkavp.arg>
 <20130405094159.GH17995@n2100.arm.linux.org.uk>
 <201304052233.25630.arnd@arndb.de>
Message-ID: <CAOesGMiN1oEMTjVVOiXs2ynccnvTgFgn=Fy1wGHhsGqL0XUATQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 5, 2013 at 1:33 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 05 April 2013, Russell King - ARM Linux wrote:
>>
>> Now, I'm currently on holiday.  I'm going to be on holday until after
>> mid-April.  I'm not pulling anything until then.  I'm not applying anything
>> until then.  I'm not even reading this mailbox - and given current mail
>> rates at 300-400 messages per day, I will *not* be reading back over a
>> fortnights worth of email.
>
> I haven't reviewed the patches before, and only heard of the controversy
> from Nico's email yesterday. Independent of your personal situation and
> who implemented the code, I think it's clear that a lot of people (not
> just Linaro) want to see it get merged and not having it upstream is
> blocking platform specific code from getting put into arm-soc.

I'd prefer not to step into the middle of the personal controversy
either, but I do have some follow-on question and opinion on the code
that depends on this:

Can someone please provide a link or subject for the posted patch
series for the dependent platform code? I tried to search for it on
the lists but didn't have much luck.

> Since you are currently on holiday, I think it's best if we at least put
> it into asm-soc as a for-rmk/mcpm branch in order to give it coverage
> in linux-next and let us merge the dependent platform code into "late"
> branches for 3.10. I still hope the nontechnical issues can be resolved
> in time to let you pull it into your tree before the merge window.

I think platform code should wait until 3.11 instead of getting
crammed in at post-rc6. If it hasn't already been posted by now, it
should most definitely wait. That also saves on any contentious
dependency between the two.

> Having just looked over the code myself for the first time, it
> seems extremely much self-contained, so I see very little risk of
> regressions and I'm sure any comments you have can be addressed in
> follow-on patches.

I hope so too, but I would prefer to not build dependencies until
that's been dealt with.


-Olof
