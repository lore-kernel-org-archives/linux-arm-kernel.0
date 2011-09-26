From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 26 Sep 2011 09:58:53 -0400 (EDT)
Subject: Pull request: removal of most instances of mach/memory.h
In-Reply-To: <20110926131524.GJ22455@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.1109062158450.20358@xanadu.home>
	<alpine.LFD.2.00.1109130849590.20358@xanadu.home>
	<alpine.LFD.2.00.1109201349400.12663@xanadu.home>
	<20110926131524.GJ22455@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1109260952490.2718@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 26 Sep 2011, Russell King - ARM Linux wrote:

> On Tue, Sep 20, 2011 at 01:53:49PM -0400, Nicolas Pitre wrote:
> > Re-ping.
> > 
> > Please let me know if there is something wrong with this series as I 
> > would like to have sufficient time to fix it if needed.
> 
> I think it's fairly obvious why I've not taken this (because of the
> StrongARM changes which I've still not yet tested.)  Once I've sorted
> that out I can take it, but not before then.  Especially so as my
> firewall uses this CPU and I don't want it to break and force me
> offline as a result.

As I said in that same message:

| I also merged the patch entitled "get rid of a few StrongARM
| cache-related build time constants" as this is a prerequisite for the
| removal of mach/memory.h in mach-ebsa110 and mach-shark (more if the
| sparsemem stuff gets moved).  If you don't feel comfortable having 
| this patch merged then I can remove it along with those commits that depend
| on it.

So let me remove that and ask you to pull again.


Nicolas
