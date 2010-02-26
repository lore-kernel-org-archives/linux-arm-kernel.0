From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 26 Feb 2010 21:49:08 +0000
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <1267220429.23523.1811.camel@pasglop>
References: <1266979632.23523.1668.camel@pasglop>
	<1267201521.14703.50.camel@e102109-lin.cambridge.arm.com>
	<1267220429.23523.1811.camel@pasglop>
Message-ID: <20100226214908.GD23933@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 27, 2010 at 08:40:29AM +1100, Benjamin Herrenschmidt wrote:
> Hrm, the DMA API certainly doesn't handle the I$/D$ coherency on
> powerpc.. I'm afraid that whole cache handling stuff is totally
> inconsistent since different archs have different expectations here.

It doesn't on ARM either.
