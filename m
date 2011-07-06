From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Jul 2011 18:42:48 +0100
Subject: [PATCH 1/3] ARM: CSR: Adding CSR SiRFprimaII board support
In-Reply-To: <alpine.LFD.2.00.1107061228250.14596@xanadu.home>
References: <1309945678-18813-1-git-send-email-bs14@csr.com>
	<1309945678-18813-2-git-send-email-bs14@csr.com>
	<20110706122501.GU8286@n2100.arm.linux.org.uk>
	<201107061442.05182.arnd@arndb.de>
	<alpine.LFD.2.00.1107061228250.14596@xanadu.home>
Message-ID: <20110706174248.GK8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2011 at 12:35:54PM -0400, Nicolas Pitre wrote:
> In the spirit of removing as much machine specific and globally used 
> defines (see my patch series removing a bunch of mach/memory.h 
> instances), I'd like to see a solution that would make IO_SPACE_LIMIT 
> into a variable, or having the same definition with a fixed mapping, for 
> as many SOCs as possible.

In theory it should be possible to have it defined as 64K across
everything.  ISTR that you were against that with SA1100 platforms
because of the PCMCIA problem though...
