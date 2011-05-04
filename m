From: David.Laight@ACULAB.COM (David Laight)
Date: Wed, 4 May 2011 09:05:53 +0100
Subject: [PATCH] atomic: add *_dec_not_zero
In-Reply-To: <1304458235-28473-1-git-send-email-sven@narfation.org>
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AD0D@saturn3.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> Introduce an *_dec_not_zero operation.  Make this a special case of
> *_add_unless because batman-adv uses atomic_dec_not_zero in different
> places like re-broadcast queue or aggregation queue management. There
> are other non-final patches which may also want to use this macro.

Isn't there a place where a default definition of this can be
defined? Instead of adding it separately to every architecture.

	David
