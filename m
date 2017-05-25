From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 25 May 2017 23:10:50 +0100
Subject: [PATCH] RFC: arm: eBPF JIT compiler
In-Reply-To: <dc6d0a88-37e1-54dd-eecc-70989e997324@gmail.com>
References: <20170523232555.GY13759@lunn.ch>
 <CAHgaXdKn4J==r_22T3N_7O5oESd8xwL6L+Ot8nT9bGCsSjAkHw@mail.gmail.com>
 <20170525170051.GC18357@lunn.ch> <20170525172255.GF18357@lunn.ch>
 <CAHgaXd+CVrDEA=E2=23Qp6wk50=dBnFS6TiCtvphTBMjUywrGg@mail.gmail.com>
 <20170525182849.GG18357@lunn.ch>
 <CAHgaXdLCaTwaLiLsmkzWvzSa=67LzqwHkT6cS_CVUm9_8u2_2Q@mail.gmail.com>
 <20170525184809.GH18357@lunn.ch>
 <CAHgaXdJPSemCoaRH_5wSEE6e7sOzPg7XChuWVvykbWia4meOMw@mail.gmail.com>
 <dc6d0a88-37e1-54dd-eecc-70989e997324@gmail.com>
Message-ID: <20170525221050.GL22219@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 25, 2017 at 12:44:19PM -0700, Florian Fainelli wrote:
> Using QEMU is far less complex than the patch you wrote, the tricky
> point me be to find an ARMv6 root filesystem, unless you build the
> module into the kernel and let it run its tests.

I beg to differ - when I tried qemu during the last year, it was
basically completely non-functional for ARM, and I gave up with it.
I think what you get depends on your distro.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
