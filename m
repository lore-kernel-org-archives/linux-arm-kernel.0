From: broonie@kernel.org (Mark Brown)
Date: Mon, 27 Apr 2015 12:01:45 +0100
Subject: Question about DC-DC frequency handling
In-Reply-To: <604104768.496325.1430058690855.JavaMail.open-xchange@oxbaltgw00.schlund.de>
References: <604104768.496325.1430058690855.JavaMail.open-xchange@oxbaltgw00.schlund.de>
Message-ID: <20150427110145.GQ22845@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 26, 2015 at 04:31:30PM +0200, Stefan Wahren wrote:

> Option A):

> The regulator driver handles all internally (select clock source, set
> frequency).

This.  Nothing outside the regulator cares what clock rate it's
operating at, they just care about how good and efficient the regulation
is.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150427/94ff1f71/attachment.sig>
