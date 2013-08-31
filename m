From: slapdau@yahoo.com.au (Craig McGeachie)
Date: Sat, 31 Aug 2013 23:19:55 +1200
Subject: Query about include/linux/mailbox.h
In-Reply-To: <CABb+yY3wX2=1zh-F81YhhhgM6m+m4+fpVoKDn94m-febAhZGRg@mail.gmail.com>
References: <522177C4.8060205@yahoo.com.au>
 <CABb+yY3wX2=1zh-F81YhhhgM6m+m4+fpVoKDn94m-febAhZGRg@mail.gmail.com>
Message-ID: <5221D15B.4050507@yahoo.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/31/2013 05:33 PM, Jassi Brar wrote:
> It wasn't dropped.
> Just the development was taken offline by the three of us I (for
> Fujitsu), Suman Anna (for TI) and Loic (for STE).  Later we were
> joined by LF.Tan (for Intel). Please join us.
>   https://github.com/sumananna/mailbox/commits/jassiv3-3.10-omap should
> be good to base on.

So, this would be a good place to start?

https://github.com/sumananna/mailbox/commit/635c24eba19f67d1eb1ef7e7447f319c850b01e5#drivers/mailbox

See if I can get my head around that framework and what it does, and try 
fitting the BCM2835 mailbox into it?

Cheers,
Craig.
