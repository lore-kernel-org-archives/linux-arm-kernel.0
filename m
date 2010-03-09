From: colin.tuckley@arm.com (Colin Tuckley)
Date: Tue, 9 Mar 2010 11:07:41 -0000
Subject: [PATCH] ARM: Improve the L2 cache performance when PL310 is used
In-Reply-To: <1268131959.3239.11.camel@e102109-lin.cambridge.arm.com>
References: <20100309101248.7359.60873.stgit@e102109-lin.cambridge.arm.com>	
	<000401cabf73$79a19fa0$6ce4dee0$@tuckley@arm.com>
	<1268131959.3239.11.camel@e102109-lin.cambridge.arm.com>
Message-ID: <000501cabf78$bceab6c0$36c02440$@tuckley@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Catalin Marinas

> But do they use an L220? Or they don't use anything?

The A8 has it's own L2 cache design, the chip used on the PBA8 has a bit tacked on that makes it look a bit like a 220. I'm also told that it's possible to implement an A8 without a level two cache.

I think this is a case of reading the docs or maybe raising an Arm-support ticket.

Colin

--
Colin Tuckley - ARM Ltd.
110 Fulbourn Rd
Cambridge, CB1 9NJ
Tel: +44 1223 400536 
