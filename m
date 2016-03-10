From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 10 Mar 2016 17:59:37 +0100
Subject: ARMv4 (not v4t) marked obsolete in gcc-6
In-Reply-To: <20160310093140.GQ19428@n2100.arm.linux.org.uk>
References: <201603101013.04618.arnd@arndb.de>
 <20160310093140.GQ19428@n2100.arm.linux.org.uk>
Message-ID: <201603101759.37183.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 March 2016, Russell King - ARM Linux wrote:
> On Thu, Mar 10, 2016 at 10:13:04AM +0100, Arnd Bergmann wrote:
> > * RiscPC, Footbridge, EBSA110: Classic systems that used to be popular in
> >   the past but only remain in small quantities as far as I know. Russell still
> >   uses them. He also uses older compilers, so probably isn't affected
> >   immediately.
> 
> And I'm unlikely to ever move off them, unless there's some miraculous
> change which means I end up with server type systems to replace them.
> That's been very unlikely for some time, as there's little interest in
> hardware people producing such platforms and I'm no longer in a position
> where, even if someone did, I'd end up with such hardware.
> 
> So I'm pretty much stuck with what I have unless I replace it with x86
> systems.

Which compiler version do you have at the moment on those? Are you also
stuck on OABI for the same reasons? 

	Arnd
