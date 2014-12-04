From: broonie@kernel.org (Mark Brown)
Date: Thu, 4 Dec 2014 20:49:39 +0000
Subject: [PATCH 1/3] ARM: pxa: add regulator_has_full_constraints to
 corgi board file
In-Reply-To: <87iohrywom.fsf@free.fr>
References: <1417691402-28166-1-git-send-email-dbaryshkov@gmail.com>
 <87iohrywom.fsf@free.fr>
Message-ID: <20141204204939.GY7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 04, 2014 at 09:41:45PM +0100, Robert Jarzmik wrote:
> Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> writes:

> > +	regulator_has_full_constraints();

> Added Mark for review, as I was thinking regulator_has_full_constraints() was to
> be used to disable unused regulators, a bit like in the clock framework, rather
> than provide a way to provide automatically dummy regulators.

> If Mark acks, I'll take the serie.

It's both, it's telling the core that the board has told it about all
the regulator mappings it's ever going to tell it about.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141204/a6120d72/attachment.sig>
