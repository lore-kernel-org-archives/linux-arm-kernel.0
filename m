From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 13 Jan 2010 10:36:27 +0000
Subject: [RFC 08/18] arm: msm: set L2CR1 to enable prefetch
	andburstonScorpion.
In-Reply-To: <1263320590.3497.3.camel@c-dwalke-linux.qualcomm.com>
References: <1263320590.3497.3.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <1263378987.32612.17.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-01-12 at 18:23 +0000, Daniel Walker wrote:
> On Tue, 2010-01-12 at 14:41 +0000, Catalin Marinas wrote:
> > My argument was that ACTLR is implementation-defined, so other cores
> > like Scorpion may have a different meaning for such bits (Daniel's
> > patches are probably held in the moderation queue, I only saw your
> > replies).
> 
> Yeah, they are being held for moderator approval ("Message has a
> suspicious header") .. I see a lot of other patchsets going through,
> does anyone have a location for the right method to submit a series to
> this list?

The problem is that subsequent patches probably came as replies to the
top e-mail but without the "Re: " prefix (which is fine). However, the
mail filters may reject mails with "In-Reply-To" headers without "Re: "
in the subject.

If you use Git, it has some options to send patches unthreaded (which I
don't particularly like but that's a way around this problem; an
alternative is to convince the moderator to remove this rule).

-- 
Catalin
