From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 10 Mar 2016 17:09:00 +0000
Subject: ARMv4 (not v4t) marked obsolete in gcc-6
In-Reply-To: <201603101759.37183.arnd@arndb.de>
References: <201603101013.04618.arnd@arndb.de>
 <20160310093140.GQ19428@n2100.arm.linux.org.uk>
 <201603101759.37183.arnd@arndb.de>
Message-ID: <20160310170859.GR19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 10, 2016 at 05:59:37PM +0100, Arnd Bergmann wrote:
> On Thursday 10 March 2016, Russell King - ARM Linux wrote:
> > On Thu, Mar 10, 2016 at 10:13:04AM +0100, Arnd Bergmann wrote:
> > > * RiscPC, Footbridge, EBSA110: Classic systems that used to be popular in
> > >   the past but only remain in small quantities as far as I know. Russell still
> > >   uses them. He also uses older compilers, so probably isn't affected
> > >   immediately.
> > 
> > And I'm unlikely to ever move off them, unless there's some miraculous
> > change which means I end up with server type systems to replace them.
> > That's been very unlikely for some time, as there's little interest in
> > hardware people producing such platforms and I'm no longer in a position
> > where, even if someone did, I'd end up with such hardware.
> > 
> > So I'm pretty much stuck with what I have unless I replace it with x86
> > systems.
> 
> Which compiler version do you have at the moment on those? Are you also
> stuck on OABI for the same reasons?

Well, the compiler version on the platforms is irrelevant as they're
cross-built kernels, for which I'm currently using gcc 4.7.4 for all
kernel builds.

The platforms themselves are pretty much stuck on OABI for ever
because there's no way to progressively convert them to EABI in a
sane manner.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
