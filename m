From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 9 Aug 2012 15:01:37 +0100
Subject: imx6q restart is broken
In-Reply-To: <20120809135755.GR18957@n2100.arm.linux.org.uk>
References: <20120808101817.GA14718@S2101-09.ap.freescale.net>
 <50224547.9020000@de.bosch.com> <50232C17.9000700@gmail.com>
 <20120809092021.GQ18957@n2100.arm.linux.org.uk>
 <20120809120144.GA19617@S2101-09.ap.freescale.net>
 <20120809122220.GB19617@S2101-09.ap.freescale.net>
 <20120809135755.GR18957@n2100.arm.linux.org.uk>
Message-ID: <20120809140137.GS18957@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 09, 2012 at 02:57:55PM +0100, Russell King - ARM Linux wrote:
> Then try running some other programs.  If I'm correct, this should
> result in the system becoming rather unresponsive.

I should better describe what I mean by "unresponsive" - it won't lock
the system up (because the dmb loop will be interrupted from time to
time) but it should make it rather sluggish to deal with page faults on
other CPUs.
