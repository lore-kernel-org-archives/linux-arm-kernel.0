From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 30 Jan 2013 10:38:03 +0000
Subject: [GIT PULL] vexpress: drivers for v3.9
In-Reply-To: <CAOesGMinJef-9OsKi0LGB0W6i73sgyUqhm2Mie4gyC2JLjnd1Q@mail.gmail.com>
References: <1359484450.8090.27.camel@hornet>
 <CAOesGMinJef-9OsKi0LGB0W6i73sgyUqhm2Mie4gyC2JLjnd1Q@mail.gmail.com>
Message-ID: <1359542283.8090.32.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Morning,

> > Pawel Moll (1):
> >       mfd: vexpress: Add pseudo-GPIO based LEDs
> 
> I can't find record of this patch ever having been posted (under that
> subject at least) on any list I am on, including linux-arm-kernel and
> linux-kernel.

Uh, the brief LEDs discussion happened so long ago (almost 3 months)
that I was convinced I posted it back then. Should have checked it
myself, sorry.

> You should at least post it to those lists, and cc the MFD maintainer.
> And you should get his ack if you are going to merge this patch
> through arm-soc instead of through his tree.

You're right, I'll approach Samuel regarding this bit.

In the meantime, could you please take the other patch please? I mean:

> > Catalin Marinas (1):
> >       arm: Move sp810.h to include/linux/amba/

I can rework the branch to contain this patch only and send a new pull
request if you prefer.

Thanks!

Pawe?
