From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 26 Jul 2011 17:51:47 -0400 (EDT)
Subject: [PATCH v2] ARM: alignment: Prevent ignoring of faults with ARMv6
	unaligned access model
In-Reply-To: <20110726213522.GI1655@n2100.arm.linux.org.uk>
References: <1311689651-7372-1-git-send-email-dave.martin@linaro.org>
	<alpine.LFD.2.00.1107261723040.12766@xanadu.home>
	<20110726213522.GI1655@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1107261750000.12766@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Jul 2011, Russell King - ARM Linux wrote:

> On Tue, Jul 26, 2011 at 05:28:57PM -0400, Nicolas Pitre wrote:
> > Why not clearing the U bit as well as the A bit to preserve consistency 
> > with the pre ARMv6 behavior?
> 
> Because some CPUs have the U bit forced to 1.  IOW, it's not possible to
> disable it.

Oh well...


Nicolas
