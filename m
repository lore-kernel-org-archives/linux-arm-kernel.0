From: nico@cam.org (Nicolas Pitre)
Date: Mon, 24 Aug 2009 13:43:01 -0400 (EDT)
Subject: New SoC - where does it go?
In-Reply-To: <1251134338.5257.15.camel@jmcmullan-laptop>
References: <1251134338.5257.15.camel@jmcmullan-laptop>
Message-ID: <alpine.LFD.2.00.0908241340440.6044@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 24 Aug 2009, Jason McMullan wrote:

> I'm working on a Linux port for our new SoC, and I'm wondering where
> everything should go.
> 
> We're using an ARM MP11 core, and I currently have everything
> (SoC support and board config) in the same mach-FOO directory.
> 
> Should I split this into a plat-FOO and a mach-FOO, and if so,
> what should go where?

If you don't see a reason for such a split then just don't do it.
The plat-foo directory is used only when some code can be shared between 
otherwise incompatible SOCs.


Nicolas
