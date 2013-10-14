From: broonie@kernel.org (Mark Brown)
Date: Mon, 14 Oct 2013 17:37:53 +0100
Subject: [PATCH 4/4] sound/soc/atmel: don't use
 devm_pinctrl_get_select_default() in probe
In-Reply-To: <20131014145629.GA17351@katana>
References: <1381681071-6021-1-git-send-email-wsa@the-dreams.de>
 <1381681071-6021-5-git-send-email-wsa@the-dreams.de>
 <20131014131748.GU2443@sirena.org.uk>
 <20131014145629.GA17351@katana>
Message-ID: <20131014163753.GF2443@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 14, 2013 at 04:56:29PM +0200, Wolfram Sang wrote:

> > Applied, thanks.  Please use subject lines appropriate to the subsystem.

> That's quite a nut to crack with a generated patch series running over
> the whole tree. I wonder if it is really worth the effort?

I think it's probably worth the effort to add something to put rules for
these things in MAINTAINERS, it'd cover 90% of cases.  If you're sending
only one of a big series with a subject line that won't pattern match
that's a good way to get stuff dropped on the floor.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131014/f19038b2/attachment.sig>
