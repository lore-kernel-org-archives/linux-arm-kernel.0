From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Nov 2011 14:49:34 +0000
Subject: [RFC 0/5] restart cleanups
In-Reply-To: <1320241747.20107.41.camel@ted>
References: <20111101160731.GQ19187@n2100.arm.linux.org.uk>
	<20111101170225.GS19187@n2100.arm.linux.org.uk>
	<1320241747.20107.41.camel@ted>
Message-ID: <20111102144934.GJ19187@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 02, 2011 at 01:49:07PM +0000, Richard Purdie wrote:
> >From what I remember that hardware either always reboots or always
> halts. I think the option was therefore left hardcoded to make it clear
> it wasn't expected to work. Later Zaurii models could do either but
> required some manual poking of registers to make it happen iirc.
> 
> Regardless, you can probably clean this up as you suggest now.

Thanks, I've now committed a change which removes the indirection
entirely from poodle.
