From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Jul 2011 14:41:02 +0100
Subject: [PATCH] ARM: get rid of a few StrongARM cache-related build
	time constants
In-Reply-To: <alpine.LFD.2.00.1107060912490.14596@xanadu.home>
References: <1309919636-20546-1-git-send-email-nicolas.pitre@linaro.org>
	<20110706075542.GK8286@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1107060912490.14596@xanadu.home>
Message-ID: <20110706134102.GZ8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2011 at 09:21:33AM -0400, Nicolas Pitre wrote:
> Oops.  Here's a fixed patch.
> 
> Could you test this patch as well?  You're the only one I know who might 
> still have access to the affected hardware.

Will do - the assabet is still running as a test machine.  The ebsa110 is
still alive but as that's (still) the firewall I won't run a test on that
until a quiet weekend.  I can also test the Netwinder and RiscPC...
