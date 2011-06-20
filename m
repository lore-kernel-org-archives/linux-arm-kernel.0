From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 20 Jun 2011 09:52:01 -0400 (EDT)
Subject: [PATCH 0/2] kuser helpers documentation cleanup and 64-bit cmpxchg
In-Reply-To: <20110620132150.GA6310@arm.com>
References: <1308502494-20938-1-git-send-email-nico@fluxnic.net>
	<20110620132150.GA6310@arm.com>
Message-ID: <alpine.LFD.2.00.1106200949370.2142@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 20 Jun 2011, Dave Martin wrote:

> On Sun, Jun 19, 2011 at 12:54:52PM -0400, Nicolas Pitre wrote:
> > This series cleans up the kuser documentation, then it adds 64-bit
> > cmpxchg support as needed by some user space applications.
> > 
> > [PATCH 1/2] ARM: kuser: move interface documentation out of the source code
> > [PATCH 2/2] ARM: add a kuser_cmpxchg64 user space helper
> 
> Hi again,
> 
> It looks like these patches apply on top of my
> 'ARM: kuser helpers: comment cleanup' patch, which didn't receive any
> comments or acks and hasn't been merged.
Yes, I merged it initially then folded it with the move as I mentioned 
in my previous email.


Nicolas
