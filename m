From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 28 Nov 2009 18:27:09 +0000
Subject: my IXP4xx git tree
In-Reply-To: <m3iqcuy4ge.fsf@intrepid.localdomain>
References: <m3iqcuy4ge.fsf@intrepid.localdomain>
Message-ID: <20091128182709.GC497@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 28, 2009 at 05:55:13PM +0100, Krzysztof Halasa wrote:
> Russell,
> 
> I've prepared my IXP4xx tree for this merge window. I'm going to send it
> to Linus but perhaps you'd prefer to handle it yourself instead?

If you have ARM generic stuff which hasn't been acked then I'd prefer you
didn't send it to Linus directly.

Fine if you're only sending stuff private to your own area, but when you
have the potential of clashing with other platforms or generic code, that's
certainly not nice.

I'm NAKing the change to arch/arm/include/asm/io.h
