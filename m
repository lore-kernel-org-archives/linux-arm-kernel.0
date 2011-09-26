From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 26 Sep 2011 14:15:24 +0100
Subject: Pull request: removal of most instances of mach/memory.h
In-Reply-To: <alpine.LFD.2.00.1109201349400.12663@xanadu.home>
References: <alpine.LFD.2.00.1109062158450.20358@xanadu.home>
	<alpine.LFD.2.00.1109130849590.20358@xanadu.home>
	<alpine.LFD.2.00.1109201349400.12663@xanadu.home>
Message-ID: <20110926131524.GJ22455@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 20, 2011 at 01:53:49PM -0400, Nicolas Pitre wrote:
> Re-ping.
> 
> Please let me know if there is something wrong with this series as I 
> would like to have sufficient time to fix it if needed.

I think it's fairly obvious why I've not taken this (because of the
StrongARM changes which I've still not yet tested.)  Once I've sorted
that out I can take it, but not before then.  Especially so as my
firewall uses this CPU and I don't want it to break and force me
offline as a result.

However, as you've guessed I don't currently have the bandwidth to
test those changes at the moment - and as the rest of this series
relies on that change, it would be very difficult to revert it later
if it proves to be a problem.
