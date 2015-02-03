From: dhowells@redhat.com (David Howells)
Date: Tue, 03 Feb 2015 15:14:43 +0000
Subject: [RFC] change non-atomic bitops method
In-Reply-To: <20150202193154.GC10842@pengutronix.de>
References: <20150202193154.GC10842@pengutronix.de>
 <35FD53F367049845BC99AC72306C23D1044A02027E0A@CNBJMBX05.corpusers.net>
Message-ID: <30242.1422976483@warthog.procyon.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uwe Kleine-K?nig  wrote:

> Might be a matter of taste, but this check is equivalent to
> 
> 	*p != (*p | mask)
> 
> which is what you really want to test for.

I would argue that this is less clear as to what's going on.

David
