From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 31 Jul 2011 16:12:05 +0100
Subject: [PULL] at91 init factorize
In-Reply-To: <20110731034417.GA6255@game.jcrosoft.org>
References: <20110727121156.GK10037@game.jcrosoft.org>
	<201107271647.44015.arnd@arndb.de>
	<20110727233452.GN10037@game.jcrosoft.org>
	<201107281758.27738.arnd@arndb.de>
	<20110730074623.GG25658@game.jcrosoft.org>
	<alpine.LFD.2.00.1107301434160.12766@xanadu.home>
	<20110731034417.GA6255@game.jcrosoft.org>
Message-ID: <20110731151205.GB2975@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 31, 2011 at 05:44:17AM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> let this pull go and theere was no announch that we can not send pull during
> the merge windows so if there is such rule we must write a patch and put it
> in the ARM tree to specified the ARM merge window otherwise the merge normal
> merge window prime

Err, what?  That doesn't parse.

Look - it's a requirement that code for the merge window is in linux-next
prior to the merge window opening.

What that means is that if code has not been in the linux-next tree prior
to the merge window opening, it doesn't get merged during the window, and
has to wait until the end of the merge window.

Moreover, new code must not be added to linux-next _during_ the merge
window by anyone (apart from bug fixes) as that can disrupt sorting out
how trees are merged into Linus' tree.

So, the rule has been for years: code not in linux-next does not get
merged during the merge window.

There's nothing new there.
