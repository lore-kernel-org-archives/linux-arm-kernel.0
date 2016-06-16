From: glider@google.com (Alexander Potapenko)
Date: Thu, 16 Jun 2016 18:36:08 +0200
Subject: [PATCH v2] arm64: allow building with kcov coverage on ARM64
In-Reply-To: <20160616163258.GA1459@leverpostej>
References: <20160614175543.GA2468@leverpostej>
 <CAG_fn=X521a9uD1bthDZ-swO9hrfq=jE2C_LUvzkn6C_q5dBvA@mail.gmail.com>
 <20160615092509.GA3984@leverpostej> <20160615114438.GC3984@leverpostej>
 <CAG_fn=U7-fUnw1GLwBbmqGTxnOWf4QcTjTyP4mGAORfEuWt3Eg@mail.gmail.com>
 <20160615142550.GA7971@leverpostej> <576283B9.9050900@arm.com>
 <CAG_fn=X=LSEN2FS0rapgW1PEEqkDLcSXLdxeKa=5ya9g0GJ23A@mail.gmail.com>
 <20160616154412.GC31477@leverpostej>
 <20160616162531.GF18752@e104818-lin.cambridge.arm.com>
 <20160616163258.GA1459@leverpostej>
Message-ID: <CAG_fn=VQjzPCeVrCLaJPnB1y4yE5z+5JAyZJgmeDiJA_upsHfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 16, 2016 at 6:32 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Thu, Jun 16, 2016 at 05:25:31PM +0100, Catalin Marinas wrote:
>> On Thu, Jun 16, 2016 at 04:44:12PM +0100, Mark Rutland wrote:
>> > On Thu, Jun 16, 2016 at 05:20:03PM +0200, Alexander Potapenko wrote:
>> > > I think it's time to ask now :)
>> > > If I receive "Tested-by" or "Acked-by" responses, do I need to send
>> > > out a patch adding them, or should I rely on the maintainer taking the
>> > > patch to the tree?
>> > > The first option reduces the amount of work done by the maintainer,
>> > > while the second one reduces the traffic in the list.
>> > > Sorry, I couldn't find the answer in the manuals.
>> >
>> > It's up to the maintainer, so it varies. The best thing to do is to ask
>> > the maintainer what they'd prefer.
>> >
>> > From my experience, Catalin is usually happy to add tags, so I suspect
>> > he'd be happy to do so for this patch (assuming he's happy to pick it
>> > up). I'll leave it for him to say either way.
>>
>> I usually cherry-pick tags that I see in reply to the *latest* version
>> of the patch (I have a rudimentary script to do this).
>>
>> I noticed that there was an ack on v1 form Marc Z that's missing in v2.
>
> I believe Marc's reply [1] was to v3 [2], it's just that the version was
> missing form the subject, and discussions continued on v2 in the mean
> time.
Yes, this is correct.
>> Maybe it no longer applies, I can't tell, but I usually expect
>> subsequent versions of a patch to include all the previously given acks
>> (of course, if they still apply, sometimes a patch rewrite means
>> dropping those tags).
>
> I guess the simplest thing to do is for Alexander to send a v4 with the
> tags accumulated, assuming James's Tested-by is applicable to v3 with
> the boot/Makefile hunk removed. James?
I think it's safe to assume James's Tested-by is still valid, as
boot/Makefile hunk did virtually nothing.
I'll send the new patch version now.
> My ack stands.
>
> Thanks,
> Mark.
>
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-June/436551.html
> [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-June/436512.html



-- 
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra?e, 33
80636 M?nchen

Gesch?ftsf?hrer: Matthew Scott Sucherman, Paul Terence Manicle
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
