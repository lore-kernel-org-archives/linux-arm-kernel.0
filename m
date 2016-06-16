From: james.morse@arm.com (James Morse)
Date: Thu, 16 Jun 2016 17:36:33 +0100
Subject: [PATCH v2] arm64: allow building with kcov coverage on ARM64
In-Reply-To: <CAG_fn=VQjzPCeVrCLaJPnB1y4yE5z+5JAyZJgmeDiJA_upsHfg@mail.gmail.com>
References: <20160614175543.GA2468@leverpostej>
 <CAG_fn=X521a9uD1bthDZ-swO9hrfq=jE2C_LUvzkn6C_q5dBvA@mail.gmail.com>
 <20160615092509.GA3984@leverpostej> <20160615114438.GC3984@leverpostej>
 <CAG_fn=U7-fUnw1GLwBbmqGTxnOWf4QcTjTyP4mGAORfEuWt3Eg@mail.gmail.com>
 <20160615142550.GA7971@leverpostej> <576283B9.9050900@arm.com>
 <CAG_fn=X=LSEN2FS0rapgW1PEEqkDLcSXLdxeKa=5ya9g0GJ23A@mail.gmail.com>
 <20160616154412.GC31477@leverpostej>
 <20160616162531.GF18752@e104818-lin.cambridge.arm.com>
 <20160616163258.GA1459@leverpostej>
 <CAG_fn=VQjzPCeVrCLaJPnB1y4yE5z+5JAyZJgmeDiJA_upsHfg@mail.gmail.com>
Message-ID: <5762D591.5090702@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/06/16 17:36, Alexander Potapenko wrote:
> On Thu, Jun 16, 2016 at 6:32 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>> On Thu, Jun 16, 2016 at 05:25:31PM +0100, Catalin Marinas wrote:
>>> I noticed that there was an ack on v1 form Marc Z that's missing in v2.
>>
>> I believe Marc's reply [1] was to v3 [2], it's just that the version was
>> missing form the subject, and discussions continued on v2 in the mean
>> time.

Ah, that's what happened...


> Yes, this is correct.
>>> Maybe it no longer applies, I can't tell, but I usually expect
>>> subsequent versions of a patch to include all the previously given acks
>>> (of course, if they still apply, sometimes a patch rewrite means
>>> dropping those tags).
>>
>> I guess the simplest thing to do is for Alexander to send a v4 with the
>> tags accumulated, assuming James's Tested-by is applicable to v3 with
>> the boot/Makefile hunk removed. James?

> I think it's safe to assume James's Tested-by is still valid, as
> boot/Makefile hunk did virtually nothing.

I agree!

> I'll send the new patch version now.


Thanks,

James
