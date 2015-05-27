From: broonie@kernel.org (Mark Brown)
Date: Wed, 27 May 2015 19:39:08 +0100
Subject: [PATCH 2/3] spi: orion: Fix extended baud rates for each Armada
 SoCs
In-Reply-To: <55660343.9060200@free-electrons.com>
References: <1432633484-18758-1-git-send-email-gregory.clement@free-electrons.com>
 <1432633484-18758-3-git-send-email-gregory.clement@free-electrons.com>
 <20150526120853.GB28523@lunn.ch>
 <556464F8.1020707@free-electrons.com>
 <20150527174547.GI21577@sirena.org.uk>
 <55660343.9060200@free-electrons.com>
Message-ID: <20150527183908.GN21577@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 27, 2015 at 07:47:47PM +0200, Gregory CLEMENT wrote:
> On 27/05/2015 19:45, Mark Brown wrote:

> > I fixed it up locally (in general it's easier to just send the patch
> > though).

> Thanks! And next time I will send a v2 then if it is easier for you.

I'd say it's just easier in general - "can you please either fix this up
locally or apply this patch" means that whatever the answer is it can be
acted on immediately.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150527/71e1ddc6/attachment-0001.sig>
