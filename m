From: broonie@kernel.org (Mark Brown)
Date: Wed, 12 Feb 2014 17:16:44 +0000
Subject: [linux-sunxi] Re: [PATCH 3/3] mfd: axp20x: Add bindings
 documentation
In-Reply-To: <CAOQ7t2ZT-3OnG-1BjGS9c6jdbzt1rDHRQ9ptOaXbewypiG_oBw@mail.gmail.com>
References: <1391875428-6281-1-git-send-email-carlo@caione.org>
 <1391875428-6281-4-git-send-email-carlo@caione.org>
 <20140210201215.GC3192@lukather>
 <CAOQ7t2YBhUuVQuDhkCux4ogb8_W2Ja1RMn4+UtcUpYrR84Boug@mail.gmail.com>
 <20140210220102.GG3192@lukather>
 <CAOQ7t2ZT-3OnG-1BjGS9c6jdbzt1rDHRQ9ptOaXbewypiG_oBw@mail.gmail.com>
Message-ID: <20140212171644.GH28112@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 11:38:47PM +0100, Carlo Caione wrote:
> On Mon, Feb 10, 2014 at 11:01 PM, Maxime Ripard

> > Ok. What's the difference between the two then?

> Honestly I have no idea. For what I have seen (core, PEK and
> regulators) AXP202 and AXP209 are identical.

I'd guess something in the electrical or mechanical specs (eg, maximum
current draws or packaging which are often related anyway), it's quite
common to get multiple PMICs that are silicon identical but differently
packaged or binned.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140212/95bb7c52/attachment.sig>
