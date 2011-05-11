From: ospite@studenti.unina.it (Antonio Ospite)
Date: Wed, 11 May 2011 22:19:14 +0200
Subject: [PATCH v2 1/2] pxamci: remove the ifdef CONFIG_REGULATOR
In-Reply-To: <m38vud2taw.fsf@pullcord.laptop.org>
References: <20110510203629.GB8726@opensource.wolfsonmicro.com>
	<1305109145-16567-1-git-send-email-ospite@studenti.unina.it>
	<m38vud2taw.fsf@pullcord.laptop.org>
Message-ID: <20110511221914.b09c1753.ospite@studenti.unina.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 11 May 2011 10:41:43 -0400
Chris Ball <cjb@laptop.org> wrote:

> On Wed, May 11 2011, Antonio Ospite wrote:
[...]
> >  drivers/mmc/host/pxamci.c |    5 ++---
> >  1 files changed, 2 insertions(+), 3 deletions(-)
[...]
> 
> Thanks, I've merged this and squashed the 2/2 punctuation patch into it;
> it didn't seem worth having a separate patch when both touch the same code.
> 

That's perfectly fine with me.

Thanks,
   Antonio

-- 
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110511/260c91c5/attachment.sig>
