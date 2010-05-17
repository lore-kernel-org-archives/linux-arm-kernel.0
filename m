From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 May 2010 10:03:10 +0100
Subject: RMK closing tree to patches *this* weekend
In-Reply-To: <20100513230201.GA26822@n2100.arm.linux.org.uk>
References: <20100513230201.GA26822@n2100.arm.linux.org.uk>
Message-ID: <20100517090310.GE23118@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 14, 2010 at 12:02:01AM +0100, Russell King - ARM Linux wrote:
> As of the end of this coming weekend, I'll stop taking patches for the
> next merge window.  I want to tidy up the lose ends which need sorting
> out and give it a decent outing in linux-next for about a week before
> the merge window opens.

So 2.6.34 has happened, so much for having a week for things to settle
down.

Right, my tree is now frozen for new patches; I won't be taking any
more patches into the devel side from the patch system, and I won't
be pulling any further trees into my tree either.

I'm waiting for two additional patches which go on top of everything
that's been merged so far (which have dependencies on previously merged
stuff), and then I'll push out the final version.
