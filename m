From: luke.leighton@gmail.com (luke.leighton)
Date: Fri, 7 Jun 2013 20:14:47 +0100
Subject: [Arm-netbook] getting allwinner SoC support upstream (was Re:
 Uploading linux (3.9.4-1))
In-Reply-To: <20130607205940.4816fed5@skate>
References: <CAPweEDx3mAy40BZrzrKPRbvg7vKMj7KevDQ3m_v4p6Yo50eSGg@mail.gmail.com>
 <1370475609.20454.44.camel@localhost>
 <CAPweEDwS3tR=wh-bZJb3vqR8fVQra=3XxDitowGRdH9c7WRfmQ@mail.gmail.com>
 <1733666.lHUBcfUXq9@flatron> <20130606112723.71ddd70c@skate>
 <CAPweEDzW60poOYahm31aW3_A=NvZmyBPPPgM9PzdvuPJnju69A@mail.gmail.com>
 <20130607205940.4816fed5@skate>
Message-ID: <CAPweEDzaWBYEOpDNCkxGyHzewTAVgD6v=Jjm-T46UW_jyPbKxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 7, 2013 at 7:59 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Hello,
>
> On Fri, 7 Jun 2013 19:26:49 +0100, luke.leighton wrote:
>
>> > Have you noticed that it is already the case in mainline?
>>
>>  i knew there was a little bit, but not the extent of the commits.
>
> Then you could probably use a bit of your time to read the kernel
> commit logs rather than writing hundreds of e-mails, no?

 not now, thomas.  i need summaries.  bear in mind i type faster than
i can read/find.  very very grateful for your summaries, it's exactly
what i need.

>> > My colleague Maxime Ripard (Cc'ed)
>>
>>  maxime: we need to talk :)
>>
>>  please tell me in 4 or 5 sentences what you've managed to do so far,
>> expanding a little on what thomas says below, more specifically what
>> it achieves and/or allows rather than technically what it does
>> (suitable for managers and directors in other words), and what plans
>> you'd like to see happen.
>
> Maxime will reply to this in more details, but I believe the status is:
>
>  * Interrupt controller is working.
>  * Clock drivers are working.
>  * Pinctrl is working.
>  * GPIO is working.
>  * Timer is working.
>  * UART is working
>  * Watchdog is on its way (patches posted)
>  * Ethernet is on its way (patches posted)
>  * I2C is on its way (patches posted)
>
> Cubieboard (A10), Hackberry (A10), Mini XPlus (A10) And OLinuxino (A13)
> are supported.
>
> See arch/arm/boot/dts/sun{4,5}i* for a good overview.
>
>> > All in mainline, completely Device Tree based.
>>
>>  great.  which version did it first hit, i.e. what will the first
>> signs of this be when allwinner begin doing "git pulls"?
>
> The very first support landed in 3.8.
>
>> > So isn't this entire discussion completely moot?
>>
>>  no because it's totally in isolation from allwinner.  i need to give
>> them a heads-up, and get them involved, giving them specific
>> incentives [which nobody's yet given!!] for following a particular
>> path [or paths] yet to be recommended.
>
> You really believe you're more important than you really are, I'd say.

 no, i don't.  i'm just a messenger.  under-informed one, at the
moment.  please bear that in mind rather than saying "you seem
dreadfully underinformed" - i got caught off-guard by this opportunity
and need to get up-to-speed rather fast.

> My colleague Maxime is in contact with Allwinner, he has regular
> discussion with them, started reviewing some of the kernel code they're
> writing, has received datasheets from them, and evaluation boards.

 _great_.  that's brilliant to hear.

> So this work is definitely not done in isolation from Allwinner, and
> they have received much more than an heads-up from Maxime.
>
>> > The mainline support
>> > for sunxi has already started since 6 months or so, and has been Device
>> > Tree based from day one.
>>
>> to clarify: the *community-driven* mainline support for sunxi.  ok -
>> which chips?  sun3i (ARM9), sun4i (Cortex A8), sun5i, sun6i and sun7i
>> (Dual-Core Cortex A7)?  which ones are in?
>
> So far, A10 and A13. Maxime has received a A31 evaluation board from
> Allwinner very recently, and also A10S and A20 boards. I suppose he
> will be working on those fairly and posting the corresponding patches
> fairly soon.

 great.   you've got the A20 3.3 kernel source drop?
 http://git.rhombus-tech.net/?p=linux.git;a=tree;h=refs/heads/lkcl-3.3-a20;hb=refs/heads/lkcl-3.3-a20


> In other words, it looks like you've started an entire discussion about
> the mainline support for Allwinner SoCs without having a look at what
> "git log" tells you...

 absolutely correct.  dived into this the moment i got word of a
potential meeting on extremely short notice, having had zero time to
review the logs prior even to then.

> Which by itself is a very good indicator that
> you're probably not the best interlocutor for Allwinner as far as
> mainline development is concerned.

 the meeting's going ahead, regardless of your concerns.  please help
get me up to speed, for the benefit of the linux community.  take
advantage of the opportunity, please: take it at face value without
judgement.

l.
