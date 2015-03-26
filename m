From: broonie@kernel.org (Mark Brown)
Date: Thu, 26 Mar 2015 09:00:57 -0700
Subject: [RFC 4/6] spi: atmel: use atmel_io.h to provide on-chip IO
In-Reply-To: <551428A9.9090604@atmel.com>
References: <1427370354-21247-1-git-send-email-ben.dooks@codethink.co.uk>
 <1427370354-21247-5-git-send-email-ben.dooks@codethink.co.uk>
 <20150326153855.GP3572@sirena.org.uk> <551428A9.9090604@atmel.com>
Message-ID: <20150326160057.GQ3572@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 26, 2015 at 04:41:29PM +0100, Nicolas Ferre wrote:
> Le 26/03/2015 16:38, Mark Brown a ?crit :

> > To repeat the feedback on your previous big endian fix: I've not been
> > CCed on the cover letter or any of the other patches so can someone tell
> > me if there are any dependencies or anything?

> Yes, there is dependency on a common header file. So I think we should
> keep the series grouped or plan a migration path.

OK, thanks for letting me know - Ben, if you're working on this stuff
*please* bear dependency issues like this in mind.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150326/44f78a79/attachment.sig>
