From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Apr 2011 14:12:40 +0200
Subject: [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <1303979259.26744.3.camel@e102109-lin.cambridge.arm.com>
References: <201104212129.17013.arnd@arndb.de> <11431.1303949729@localhost>
	<1303979259.26744.3.camel@e102109-lin.cambridge.arm.com>
Message-ID: <201104281412.40991.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 April 2011, Catalin Marinas wrote:
> On Thu, 2011-04-28 at 01:15 +0100, Valdis.Kletnieks at vt.edu wrote:
> > On Wed, 27 Apr 2011 12:08:28 BST, Catalin Marinas said:
> > 
> > > The current version of the ARM ARM says "unpredictable". But this
> > > general definition of "unpredictable" does not allow it to deadlock
> > > (hardware) or have security implications. It is however allowed to
> > > corrupt data.
> > 
> > Not allowed to have security implications, but is allowed to corrupt data.
> 
> By security I was referring to TrustZone extensions. IOW, unpredictable
> in normal (non-secure) world should not cause data corruption in the
> secure world.

That definition is rather useless for operating systems that don't use
Trustzone then, right?

	Arnd
