From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 18 Apr 2010 16:09:30 +0100
Subject: [PATCH v2] ARM: Fix "BUG: scheduling while atomic:
	swapper/0/0x00000002
In-Reply-To: <4BC984BC.2060800@mvista.com>
References: <1271492144-26995-1-git-send-email-santosh.shilimkar@ti.com>
	<4BC984BC.2060800@mvista.com>
Message-ID: <20100418150930.GB15452@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 17, 2010 at 03:21:56PM +0530, Philby John wrote:
> Since Sundar was the first to suggest this fix, shouldn't his SOB be  
> included as well instead of CC ? Or did I miss a mail thread ?

I think you need to review what qualifies for a SOB line.  A SOB line
effectively means you're certifying one of the conditions given in the
developer certificate of origin.  If you're not doing that, you must
not use SOB.

In any case, as Santosh points out, it was myself who originally
suggested this approach.  However, I really can't be bothered to try
and find my email as people insist on using email clients which break
threading.
