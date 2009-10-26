From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 26 Oct 2009 11:02:46 +0000
Subject: [PATCH] Use REV and REV16 for byte swapping on ARMv6+
In-Reply-To: <20091024111357.GD16451@n2100.arm.linux.org.uk>
References: <1256374782-5803-1-git-send-email-rabin@rab.in>
	<20091024111357.GD16451@n2100.arm.linux.org.uk>
Message-ID: <1256554966.5282.15.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2009-10-24 at 12:13 +0100, Russell King - ARM Linux wrote:
> On Sat, Oct 24, 2009 at 02:29:42PM +0530, Rabin Vincent wrote:
> > ARMv6 introduced the REV and REV16 instructions that reverse bytes in
> > words and halfwords.  Use them for the arch-specific implementation of
> > the byte swapping helpers on ARMv6+.
> 
> Please submit to the patch system.  Note that you can now use this format,
> and just put the "KernelVersion:" header somewhere in before the 'diff'
> line.

(OT) Does it also now parse a "From:" line (if the author differs from
the sender)?

-- 
Catalin
