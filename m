From: lost.distance@yahoo.com (Paul Parsons)
Date: Thu, 5 Apr 2012 12:15:06 +0100 (BST)
Subject: [PATCH] ARM: pxa: mfp: Force gpio direction for
 MFP_LPM_KEEP_OUTPUT
In-Reply-To: <4F7D54D6.70206@compulab.co.il>
Message-ID: <1333624506.83658.YahooMailClassic@web29010.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Igor,

--- On Thu, 5/4/12, Igor Grinberg <grinberg@compulab.co.il> wrote:
> >> Please, check the attached patch.
> >> It should not change the meaning of KEEP_OUTPUT,
> but fix the
> >> bug.
> > 
> > Yes, your patch - pxa2xx-mfp.patch - does fix the
> KEEP_OUTPUT bug.
> 
> Looking at it one more time, we setup the GPDR with values
> from gpdr_lpm,
> and afterwards we setup them once again to update for
> KEEP_CONFIG.
> This can introduce a kind of spike on the GPIO (depending on
> how fast
> the system runs).
> So, fixed patch attached. Can you please test it once more
> and I will
> submit it properly?

Yes, I've tested it and this new patch fixes the KEEP_OUTPUT bug.

Regards,
Paul
