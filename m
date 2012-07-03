From: pebolle@tiscali.nl (Paul Bolle)
Date: Tue, 03 Jul 2012 09:20:30 +0200
Subject: [PATCH] ARM: remove asm/locks.h
In-Reply-To: <20120702215203.GA25234@mudshark.cambridge.arm.com>
References: <1341262188.1911.147.camel@x61.thuisdomein>
 <20120702215203.GA25234@mudshark.cambridge.arm.com>
Message-ID: <1341300030.1911.179.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will,

On Mon, 2012-07-02 at 22:52 +0100, Will Deacon wrote:
> On Mon, Jul 02, 2012 at 09:49:48PM +0100, Paul Bolle wrote:
> > Tested only with various git commands on the (history of the) tree.
> 
> Not sure I follow, but since this is all dead code I can't see any tests
> failing without it.

The purpose of that disclaimer is to stress that only git commands were
used to determine that removing this header is correct and safe. But
perhaps saying that I therefore "tested" this patch with git commands is
confusing.


Paul Bolle
