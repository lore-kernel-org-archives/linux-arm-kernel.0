From: broonie@kernel.org (Mark Brown)
Date: Mon, 18 Jan 2016 16:32:48 +0000
Subject: [PATCH 4/6] regulator: lp872x: Add enable GPIO pin support
In-Reply-To: <1452929533.2520.1.camel@collins>
References: <5681D7A8.2030101@ti.com> <1451387613.18148.9.camel@collins>
 <568323B7.7080101@ti.com> <1451464521.2531.4.camel@collins>
 <20151230163307.GW16023@sirena.org.uk>
 <1451500639.14341.6.camel@collins>
 <20151231214007.GC16023@sirena.org.uk>
 <1451599146.9673.2.camel@collins>
 <20151231221407.GF16023@sirena.org.uk>
 <1452929533.2520.1.camel@collins>
Message-ID: <20160118163248.GI6588@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 16, 2016 at 08:32:13AM +0100, Paul Kocialkowski wrote:

> Is there some git tree I can work with that has regulator runtime PM
> support at this point? I'll certainly end up handling the GPIO in the
> driver otherwise.

No, the last week was much more busy than I was expecting.  I'm hoping
for this week (or you could have a go at implementing it, it'd be adding
the PM operations in _regulator_enable() or _regulator_do_enable() if a
flag was set in the regulator_desc).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160118/8dd5783a/attachment.sig>
