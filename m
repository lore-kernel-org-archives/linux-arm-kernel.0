From: will.deacon@arm.com (Will Deacon)
Date: Mon, 2 Jul 2012 22:52:03 +0100
Subject: [PATCH] ARM: remove asm/locks.h
In-Reply-To: <1341262188.1911.147.camel@x61.thuisdomein>
References: <1341262188.1911.147.camel@x61.thuisdomein>
Message-ID: <20120702215203.GA25234@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Mon, Jul 02, 2012 at 09:49:48PM +0100, Paul Bolle wrote:
> Commit 64ac24e738823161693bf791f87adc802cf529ff ("Generic semaphore
> implementation") removed the last include of this header. Apparently it
> was just an oversight to keep this header. It can safely be removed now.

Hmm, looks like you're right!

Acked-by: Will Deacon <will.deacon@arm.com>

> Tested only with various git commands on the (history of the) tree.

Not sure I follow, but since this is all dead code I can't see any tests
failing without it.

Will
