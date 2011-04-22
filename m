From: mikpe@it.uu.se (Mikael Pettersson)
Date: Fri, 22 Apr 2011 20:46:45 +0200
Subject: support for operating Kirkwood in big endian mode?
In-Reply-To: <alpine.LFD.2.00.1104221049460.24613@xanadu.home>
References: <19889.37313.25234.626786@pilspetsen.it.uu.se>
	<alpine.LFD.2.00.1104221049460.24613@xanadu.home>
Message-ID: <19889.52501.293044.844916@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Pitre writes:
 > On Fri, 22 Apr 2011, Mikael Pettersson wrote:
 > 
 > > The Kirkwood docs specify that the core can be operated in both big
 > > and little endian modes, but indicate that some peripherals in the
 > > SoC require drivers to perform byteswapping in some case for big
 > > endian operation.
 > > 
 > > Does the kernel support operating a Kirkwood in big endian mode?
 > 
 > It was never attempted.  So no, the kernel doesn't support Kirkwood in 
 > BE.

I see.  Thanks for confirming that.

/Mikael
