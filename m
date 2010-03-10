From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 10 Mar 2010 17:35:03 +0000
Subject: __xchg for sizes other than 32bit
In-Reply-To: <20100310162221.GA19201@localhost>
References: <20100310162221.GA19201@localhost>
Message-ID: <20100310173503.GC12345@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 10, 2010 at 06:22:21PM +0200, Imre Deak wrote:
> recently you've added support for __cmpxchg for ARMv6+. There the assumption
> is that ldrex[bh]/strex[bh] is only supported on platforms with the 32v6K
> extension.
> 
> Currently the __xchg code uses these even without the extension. Should this
> be fixed?
