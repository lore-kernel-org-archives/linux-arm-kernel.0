From: pebolle@tiscali.nl (Paul Bolle)
Date: Tue, 09 Jun 2015 10:27:44 +0200
Subject: [PATCH v4 2/2] dma: Add Xilinx AXI Central Direct Memory Access
 Engine driver support
In-Reply-To: <alpine.DEB.2.10.1506091007530.2324@hadrien>
References: <1432228035-6569-1-git-send-email-appanad@xilinx.com>
 <1432290653.27695.97.camel@x220> <557681A7.7080202@monstr.eu>
 <1433834507.16887.3.camel@x220> <5576956B.7050901@monstr.eu>
 <alpine.DEB.2.10.1506091007530.2324@hadrien>
Message-ID: <1433838464.16887.53.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-06-09 at 10:08 +0200, Julia Lawall wrote:
> So there is nothing to do?  Or are there still cases that could be
> interesting?

See my reply to Michal.

I think that, unless we come up with a new, much simpler way to add
license info to modules, we're stuck with doing the boring checks this
currently requires. And, of course, that new way, whatever that might
be, can probably not just replace the many thousands instances of the
MODULE_LICENSE() macro that there currently are. People being not to
keen on seeing their code being, well, relicensed.


Paul Bolle
