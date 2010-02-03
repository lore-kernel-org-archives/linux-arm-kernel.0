From: jamie@shareable.org (Jamie Lokier)
Date: Wed, 3 Feb 2010 17:23:01 +0000
Subject: 32-bit Thumb-2 breakpoints
In-Reply-To: <20100111231702.GA9485@caradoc.them.org>
References: <20100111215816.GA1068@caradoc.them.org>
	<20100111223503.GD7925@n2100.arm.linux.org.uk>
	<20100111225436.GA7408@caradoc.them.org>
	<20100111231027.GA30714@shareable.org>
	<20100111231702.GA9485@caradoc.them.org>
Message-ID: <20100203172301.GD19037@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Jacobowitz wrote:
> Thankfully, both branches into IT blocks and branches
> leaving IT blocks not at the last instruction are forbidden.

Forbidden as in throws a fault, or forbidden as in "can we use this to
break out of GDB single-stepping to give third-parties a hard time
tracing my secret code"?

-- Jamie
