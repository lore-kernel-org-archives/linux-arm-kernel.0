From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 Dec 2009 17:31:44 +0000
Subject: shared memory problem on ARM v5TE using threads
In-Reply-To: <alpine.LFD.2.00.0912041222040.31174@xanadu.home>
References: <4B18F141.7070101@denx.de>
	<alpine.LFD.2.00.0912041222040.31174@xanadu.home>
Message-ID: <20091204173143.GF20386@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 04, 2009 at 12:25:55PM -0500, Nicolas Pitre wrote:
> On Fri, 4 Dec 2009, Heiko Schocher wrote:
> 
> > Hello,
> > 
> > I have the following shared mem problem on a ARM v5TE
> > processor using Linux version 2.6.28,
> 
> Could you apply this patch and test again:
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=08e445bd6a

That's almost certainly the problem, thanks Nicolas.
