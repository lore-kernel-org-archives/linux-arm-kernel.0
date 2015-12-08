From: davem@davemloft.net (David Miller)
Date: Tue, 08 Dec 2015 11:57:27 -0500 (EST)
Subject: [PATCH 00/13] mvneta Buffer Management and enhancements
In-Reply-To: <CAPv3WKeTqWXvABPHovH6dqUz_qs88Wy7Q6cbOHsujt4CM0=32g@mail.gmail.com>
References: <CAPv3WKcKm3X3Lys2HwYZXaZxPaajenF7av1wJKXqKxxwibXW4A@mail.gmail.com>
 <5661F449.5020205@gmail.com>
 <CAPv3WKeTqWXvABPHovH6dqUz_qs88Wy7Q6cbOHsujt4CM0=32g@mail.gmail.com>
Message-ID: <20151208.115727.656709346003241561.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcin Wojtas <mw@semihalf.com>
Date: Tue, 8 Dec 2015 11:56:28 +0100

> Do you think you can point to anything similar that could be a sort
> of reference for such solution?

I don't have much time to explain because I'm constantly backlogged doing
patch review, but mostly it has to do with page management and avoiding
atomic decrement/increment of page counts wherever possible while feeding
blocks to the chip and receiving packets.

Please don't ask me for any more details as I'm really backlogged doing
patch review at the moment.

Thanks.
