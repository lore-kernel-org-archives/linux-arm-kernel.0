From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 1 Jan 2010 20:24:54 +0000
Subject: Footbridge / 21285 phsical/virtual address selection patch
In-Reply-To: <1262039219.28196.124.camel@localhost>
References: <1262039219.28196.124.camel@localhost>
Message-ID: <20100101202444.GC16220@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 28, 2009 at 05:26:59PM -0500, Steve Moskovchenko wrote:
> Well...
>         
> I've run into some issues. The MMU code seems broken somewhere, and the
> kernel only works for me in NOMMU mode.

I don't believe you.  I've been booting kernels on the Netwinder and
EBSA285 platforms (with varing amounts of success because of IDE/PATA
issues.)  Nothing fundamental, just plain buggy storage driver issues.
