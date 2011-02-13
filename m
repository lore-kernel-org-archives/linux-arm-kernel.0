From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 13 Feb 2011 11:40:50 +0000
Subject: The p2v branch
In-Reply-To: <alpine.LFD.2.00.1102121556330.14920@xanadu.home>
References: <alpine.LFD.2.00.1102121304500.14920@xanadu.home>
	<20110212184138.GD22402@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1102121556330.14920@xanadu.home>
Message-ID: <20110213114050.GB4799@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 12, 2011 at 04:01:14PM -0500, Nicolas Pitre wrote:
> I've rebased my 2 patches on top of your latest p2v branch.  You may 
> pull them from:
> 
> 	git://git.linaro.org/people/nico/linux p2v
> 
> Or if you prefer I can put them in the patch system.

I'd like to wait for Catalin to respond on the phys_addr_t patch - which
allows 64-bit phys addresses.  Obviously that's going to have an impact
on the p2v code and I'd rather someone else had the job of working out
what to do about the T2 code.
