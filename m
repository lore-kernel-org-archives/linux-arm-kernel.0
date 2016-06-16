From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 16 Jun 2016 17:25:31 +0100
Subject: [PATCH v2] arm64: allow building with kcov coverage on ARM64
In-Reply-To: <20160616154412.GC31477@leverpostej>
References: <1465923441-107596-1-git-send-email-glider@google.com>
 <20160614175543.GA2468@leverpostej>
 <CAG_fn=X521a9uD1bthDZ-swO9hrfq=jE2C_LUvzkn6C_q5dBvA@mail.gmail.com>
 <20160615092509.GA3984@leverpostej>
 <20160615114438.GC3984@leverpostej>
 <CAG_fn=U7-fUnw1GLwBbmqGTxnOWf4QcTjTyP4mGAORfEuWt3Eg@mail.gmail.com>
 <20160615142550.GA7971@leverpostej> <576283B9.9050900@arm.com>
 <CAG_fn=X=LSEN2FS0rapgW1PEEqkDLcSXLdxeKa=5ya9g0GJ23A@mail.gmail.com>
 <20160616154412.GC31477@leverpostej>
Message-ID: <20160616162531.GF18752@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 16, 2016 at 04:44:12PM +0100, Mark Rutland wrote:
> On Thu, Jun 16, 2016 at 05:20:03PM +0200, Alexander Potapenko wrote:
> > I think it's time to ask now :)
> > If I receive "Tested-by" or "Acked-by" responses, do I need to send
> > out a patch adding them, or should I rely on the maintainer taking the
> > patch to the tree?
> > The first option reduces the amount of work done by the maintainer,
> > while the second one reduces the traffic in the list.
> > Sorry, I couldn't find the answer in the manuals.
> 
> It's up to the maintainer, so it varies. The best thing to do is to ask
> the maintainer what they'd prefer.
> 
> From my experience, Catalin is usually happy to add tags, so I suspect
> he'd be happy to do so for this patch (assuming he's happy to pick it
> up). I'll leave it for him to say either way.

I usually cherry-pick tags that I see in reply to the *latest* version
of the patch (I have a rudimentary script to do this).

I noticed that there was an ack on v1 form Marc Z that's missing in v2.
Maybe it no longer applies, I can't tell, but I usually expect
subsequent versions of a patch to include all the previously given acks
(of course, if they still apply, sometimes a patch rewrite means
dropping those tags).

-- 
Catalin
