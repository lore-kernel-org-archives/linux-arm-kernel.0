From: jamie@shareable.org (Jamie Lokier)
Date: Tue, 12 Jan 2010 00:15:19 +0000
Subject: 32-bit Thumb-2 breakpoints
In-Reply-To: <20100111231536.GH7925@n2100.arm.linux.org.uk>
References: <20100111215816.GA1068@caradoc.them.org>
	<20100111223503.GD7925@n2100.arm.linux.org.uk>
	<20100111225436.GA7408@caradoc.them.org>
	<20100111231027.GA30714@shareable.org>
	<20100111231536.GH7925@n2100.arm.linux.org.uk>
Message-ID: <20100112001519.GA4465@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> itt = if then then. (if condition met, execute following two instructions)
> ite = if then else. (if condition met, execute following instruction,
>   otherwise execute the instruction following _that_ instruction.)

Yes, thinko.  Thanks all :-) Blame Wikipedia for teaching me about
those instructions; they sure were a surprise to see in regular ARM
kernel code the first time.

-- Jamie
