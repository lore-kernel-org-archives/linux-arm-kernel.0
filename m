From: davem@davemloft.net (David Miller)
Date: Sun, 27 Jun 2010 21:57:25 -0700 (PDT)
Subject: [RFC 9/9] crypto: Add Samsung crypto engine driver
In-Reply-To: <4C27309B.7010905@gmail.com>
References: <4C129341.2060407@gmail.com>
	<20100626.210728.90806559.davem@davemloft.net>
	<4C27309B.7010905@gmail.com>
Message-ID: <20100627.215725.226777011.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maurus Cuelenaere <mcuelenaere@gmail.com>
Date: Sun, 27 Jun 2010 13:06:03 +0200

> I'd go with a threaded interrupt handler in that case then, or do
> you also consider this as too much overhead?
> 
> I'll do some performance comparisons of threaded interrupt handler
> vs normal and go with the fastest.

Yes, best to just measure it in order to decide which is best.
