From: will.deacon@arm.com (Will Deacon)
Date: Tue, 22 May 2012 10:34:10 +0100
Subject: [PATCH v2] RFC: ARM: cache-l2x0: update workaround for PL310
 errata 727915
In-Reply-To: <4FBB5AE8.4000801@ti.com>
References: <1337546505-24660-1-git-send-email-linus.walleij@stericsson.com>
 <CAMQu2gy3VTtQhnVVvzgYGhr_vA=vnW=rSBW17yoBTNwkN3wHqQ@mail.gmail.com>
 <20120522085256.GA7286@mudshark.cambridge.arm.com>
 <4FBB5AE8.4000801@ti.com>
Message-ID: <20120522093410.GC7286@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2012 at 10:22:48AM +0100, Santosh Shilimkar wrote:
> On Tuesday 22 May 2012 02:22 PM, Will Deacon wrote:
> > I'm not sure I follow. Which version of the PL310 is in OMAP4460? Are you
> > saying that the current workaround didn't work but the one in this patch
> > did? Do you have a testcase?
> > 
> It's r3p1.
> IIRC, the errata fix I did(debug register) was only for flush
> (clean & inv) but Colin found in his testing that it's needed
> for clean_all as well.

Ok, interesting.

> I don't have testcase. Colin might be able to suggest one.

That would be ideal. Then I can take it up with the hardware guys since I'd
like to confirm we're not just hiding a different bug with those writes.

Cheers,

Will
