From: dan@debian.org (Daniel Jacobowitz)
Date: Mon, 11 Jan 2010 18:51:52 -0500
Subject: 32-bit Thumb-2 breakpoints
In-Reply-To: <20100111233143.GI7925@n2100.arm.linux.org.uk>
References: <20100111215816.GA1068@caradoc.them.org>
	<20100111223503.GD7925@n2100.arm.linux.org.uk>
	<20100111225436.GA7408@caradoc.them.org>
	<20100111233143.GI7925@n2100.arm.linux.org.uk>
Message-ID: <20100111235152.GA12051@caradoc.them.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2010 at 11:31:43PM +0000, Russell King - ARM Linux wrote:
> It sounds rather evil - maybe the first question that should be asked
> is whether it is legal to change the PSR flags in the middle of an IT
> block.

I'm pretty sure it is.  Catalin, do you know for sure?

-- 
Daniel Jacobowitz
CodeSourcery
