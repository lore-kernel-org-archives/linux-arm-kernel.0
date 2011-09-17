From: hemantp@ti.com (Pedanekar, Hemant)
Date: Sat, 17 Sep 2011 19:58:20 +0530
Subject: READ THIS: the next mach-types update
In-Reply-To: <20110915102528.GI6267@n2100.arm.linux.org.uk>
References: <20110915102528.GI6267@n2100.arm.linux.org.uk>
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B03B4C80171@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

linux-arm-kernel-bounces at lists.infradead.org wrote on :

> I'm going to be merging a mach-types update (the cut-down and the
> policy-conforming version) for the next merge window.  This will mean
> that things WILL BREAK, and I will not notice that things have broken.
> 
> In order to fix this, entries need to be fixed to conform to the
> requirements - where the machine_is_xxx() name is the same as the
> MACH_TYPE_xxx name and the CONFIG_MACH_xxx name too.
> 
> Moreover, entries older than 12 months which have not been merged will
> be removed.  It is not possible to automatically check for machine_is_xxx()
> usages as these could conflict with other architectures, and I'm
> certainly NOT checking for them by hand (I estimate that'd take a
> significant amount of manual effort to do.)  What that means
> is that it
> is _important_ to get the core platform support in _first_ before any
> drivers which may make use of this.
> 
> The following will be deleted from the file this time around are:
[...]

> -ti8148evm               MACH_TI8148EVM          TI8148EVM            3004

I guess this was removed due to being older than 12 months.

But since I had submitted v1 (see [1]) and am working on v2 post review, can you
please suggest how to go about it as I will need the above for adding support
for TI8148 EVM?

[1] http://www.mail-archive.com/linux-omap at vger.kernel.org/msg53457.html

Thanks.

   Hemant
