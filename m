From: sven@narfation.org (Sven Eckelmann)
Date: Wed, 4 May 2011 10:21:16 +0200
Subject: [PATCH] atomic: add *_dec_not_zero
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8AD0D@saturn3.aculab.com>
References: <AE90C24D6B3A694183C094C60CF0A2F6D8AD0D@saturn3.aculab.com>
Message-ID: <201105041021.22082.sven@narfation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 May 2011 10:05:53 David Laight wrote:
> > Introduce an *_dec_not_zero operation.  Make this a special case of
> > *_add_unless because batman-adv uses atomic_dec_not_zero in different
> > places like re-broadcast queue or aggregation queue management. There
> > are other non-final patches which may also want to use this macro.
> 
> Isn't there a place where a default definition of this can be
> defined? Instead of adding it separately to every architecture.

Not that I would know about such a place - and all other atomic* macro 
definitions also suggest that there is no such place.

Kind regards,
	Sven
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110504/1066a527/attachment.sig>
