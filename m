From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 04 Dec 2009 12:25:55 -0500 (EST)
Subject: shared memory problem on ARM v5TE using threads
In-Reply-To: <4B18F141.7070101@denx.de>
References: <4B18F141.7070101@denx.de>
Message-ID: <alpine.LFD.2.00.0912041222040.31174@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 4 Dec 2009, Heiko Schocher wrote:

> Hello,
> 
> I have the following shared mem problem on a ARM v5TE
> processor using Linux version 2.6.28,

Could you apply this patch and test again:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=08e445bd6a


Nicolas
