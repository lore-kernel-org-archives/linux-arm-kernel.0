From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 19 May 2010 18:05:53 +0900
Subject: [PATCH] ARM: Add support for 10 hardirq bits
In-Reply-To: <20100519083749.GA24520@n2100.arm.linux.org.uk>
References: <20100310111749.18521.9002.sendpatchset@t400s>
	<u2yaec7e5c31004292102rd561d7detc73e9fd2a5570ab0@mail.gmail.com>
	<20100501094436.GC12172@n2100.arm.linux.org.uk>
	<AANLkTil63uNv-S3D4ECYwT500w9sZd_8TE_T-SX0cqxv@mail.gmail.com>
	<AANLkTikTCvOIbrr4TDt2OfHrHWHIFE4Cha8YhwtLrvc7@mail.gmail.com>
	<20100519083749.GA24520@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinVmwrp8Xi7Bos1nJe5Rrs1UcxZSwGrZuqnWY4M@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Wed, May 19, 2010 at 5:37 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, May 19, 2010 at 03:16:32PM +0800, Eric Miao wrote:
>> On Thu, May 13, 2010 at 3:30 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> > Hi again Russell,
>> >
>> > Will you pick up this one in your tree as-is, or would you like me to
>> > resubmit it somehow?
>> >
>>
>> Russell,
>>
>> I don't seem to find this patch in your -devel branch. I posted a same
>> version of patch earlier, so I'd also like to see this get merged.
>>
>> Acked-by: Eric Miao <eric.y.miao@gmail.com>
>>
>> Magnus,
>>
>> I guess you may please help submit this to rmk's patch tracking system?
>
> Getting it into the patch system would be a big help, but since I've
> closed my tree down for this merge window already, it's missed the
> boat. ?(With Linus' new "random" behaviour wrt when things happen, I'm
> not planning on a second ARM kernel pull request - and the first was
> sent last night.)

It's there now:

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6138/1

Anything I can do to make a second pull request happen? There are
quite a few patches that depend on this one, so I posted it well in
advace at March 10. The patch was kindly reviewed by you a bit later.
And now I got an ack. Unfortunately I didn't proceed and submit it to
the ARM-specific patch tracking system.

> This is probably the patch I was referring to in my notice of closure
> when I said:
> | I know there was someone who was complaining a week or so ago that I
> | hadn't applied their patch, which was only sent to the mailing list.
> | Unfortunately, it being only on the mailing list and not in the patch
> | system means I can't find it, nor the complaint about it not being
> | applied.
> |
> | Whoever it was, sorry.
>
> Especially as it's 4000 messages back in this mailbox!

Sounds painful. =)

Thanks for your help!

/ magnus
