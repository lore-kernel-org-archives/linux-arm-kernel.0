From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 23 Nov 2011 17:51:57 +0000
Subject: Porting the 2.6.38 linux kernel to ARM11 MPcore
In-Reply-To: <CAK-0apYKjvxXasEfYCocjqEan5dKoXJgMON2gC-nMenKQaU9UQ@mail.gmail.com>
References: <CAK-0apYKjvxXasEfYCocjqEan5dKoXJgMON2gC-nMenKQaU9UQ@mail.gmail.com>
Message-ID: <20111123175157.GH9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2011 at 12:54:42PM +0100, Moln?r G?bor wrote:
> <5>Linux version 2.6.38-rc8 (VirtualBox) (gcc version 4.5.2 (Sourcery
> G++ Lite 2011.03-41) ) #6 Wed Nov 9 21:59:29 CET 2011
> <4>CPU: ARMv6-compatible processor [410fb025] revision 5 (ARMv7), cr=08c5387f"
> <4>CPU: VIPT nonaliasing data cache, VIPT aliasing instruction cache
> <4>Machine: ARM-RealView PB11MPCore
> <5>Ignoring RAM at c0000000-c04fffff (vmalloc region overlap).

This tells me your PHYS_OFFSET is set incorrectly.
