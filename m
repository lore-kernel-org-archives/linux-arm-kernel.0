From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 6 Jul 2011 09:51:36 -0400 (EDT)
Subject: [PATCH] ARM: get rid of a few StrongARM cache-related build time
	constants
In-Reply-To: <20110706134102.GZ8286@n2100.arm.linux.org.uk>
References: <1309919636-20546-1-git-send-email-nicolas.pitre@linaro.org>
	<20110706075542.GK8286@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1107060912490.14596@xanadu.home>
	<20110706134102.GZ8286@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1107060948430.14596@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 6 Jul 2011, Russell King - ARM Linux wrote:

> On Wed, Jul 06, 2011 at 09:21:33AM -0400, Nicolas Pitre wrote:
> > Oops.  Here's a fixed patch.
> > 
> > Could you test this patch as well?  You're the only one I know who might 
> > still have access to the affected hardware.
> 
> Will do - the assabet is still running as a test machine.  The ebsa110 is
> still alive but as that's (still) the firewall I won't run a test on that
> until a quiet weekend.  I can also test the Netwinder and RiscPC...

Thanks.  The Assabet covers SA1100, Netwinder is good for SA110, and 
RiscPC would also confirm that the change for the uncached mapping is 
harmless.  That should provide enough confidence in the patch.


Nicolas
