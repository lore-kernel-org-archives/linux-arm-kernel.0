From: tony@atomide.com (Tony Lindgren)
Date: Mon, 7 Nov 2011 12:31:11 -0800
Subject: [PATCH 1/4] ARM: OMAP3: cm-t35: add regulator supply for ads7846
In-Reply-To: <4EB68974.5090907@compulab.co.il>
References: <1319017160-20391-1-git-send-email-grinberg@compulab.co.il>
 <1319017160-20391-2-git-send-email-grinberg@compulab.co.il>
 <20111104233938.GF31337@atomide.com>
 <20111104235720.GG31337@atomide.com>
 <4EB68974.5090907@compulab.co.il>
Message-ID: <20111107203110.GX31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Igor Grinberg <grinberg@compulab.co.il> [111106 04:45]:
> Hi Tony,
> 
> On 11/05/11 01:57, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [111104 16:05]:
> >> * Igor Grinberg <grinberg@compulab.co.il> [111019 02:05]:
> >>
> >> Applying to board branch for v3.3 merge window.
> > 
> > Hmm, actually I suggest you respin patches 2 and 3 so they apply
> > on their own to current fixes branch. Then update 1 and 4 to
> > apply on top of those.
> > 
> > This way we can apply 2 and 3 during the -rc cycle, and then
> > queue 1 and 4 for the next merge window.
> 
> Well, actually all them are fixes, although it cannot be understood
> from the subject.
> I will adjust the subjects (and may be the commit messages also)
> to be more specific and resend.

Hmm 1 & 4 are "features that never worked" type fixes, so they
have flame potential. Those have to wait for the next merge window.

Patches 2 & 3 could be justified as fixes during the -rc cycle.

Or I can just apply all of them into board branch to wait for the
next merge window.

Tony
