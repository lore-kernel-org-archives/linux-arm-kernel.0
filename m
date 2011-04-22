From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 22 Apr 2011 10:58:43 -0400 (EDT)
Subject: support for operating Kirkwood in big endian mode?
In-Reply-To: <19889.37313.25234.626786@pilspetsen.it.uu.se>
References: <19889.37313.25234.626786@pilspetsen.it.uu.se>
Message-ID: <alpine.LFD.2.00.1104221049460.24613@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 22 Apr 2011, Mikael Pettersson wrote:

> The Kirkwood docs specify that the core can be operated in both big
> and little endian modes, but indicate that some peripherals in the
> SoC require drivers to perform byteswapping in some case for big
> endian operation.
> 
> Does the kernel support operating a Kirkwood in big endian mode?

It was never attempted.  So no, the kernel doesn't support Kirkwood in 
BE.  However this shouldn't be hard to achieve sor someone with interest 
and motivation as most things might just work already.

> Supposedly there's a document "AN-183" that describes the details,
> but I've not been able to locate a public copy of it.

You'd have to ask Marvell people for it I guess.  I'm no longer with 
Marvell and therefore no longer have access to the non-public documents.


Nicolas
