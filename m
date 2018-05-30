From: broonie@kernel.org (Mark Brown)
Date: Wed, 30 May 2018 10:13:14 +0100
Subject: Regression in Linux next again
In-Reply-To: <20180529221501.GJ5702@atomide.com>
References: <20180529221501.GJ5702@atomide.com>
Message-ID: <20180530091314.GB6920@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2018 at 03:15:01PM -0700, Tony Lindgren wrote:

> I think I bisected this same issue for the second time now
> but for a different merge window. What's up with that?

Last time we just reverted it as Maciej was unable to reproduce your
problem, he's tried again with some alterations.

> Reverting both patches fixes the issue for me. I could
> not debug it further because of the compile error(s).

OK, unless this gets fixed really quickly I'll revert again.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180530/89c8cec3/attachment.sig>
