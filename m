From: w@1wt.eu (Willy Tarreau)
Date: Mon, 7 Jan 2013 19:20:31 +0100
Subject: [PATCH v2] ARM: kirkwood: convert Guruplug Server Plus to use the
 device tree
In-Reply-To: <20130107181731.GQ5075@titan.lakedaemon.net>
References: <20121202155124.GA30807@1wt.eu>
 <20121202230926.GJ12509@titan.lakedaemon.net> <20121202232226.GL30822@1wt.eu>
 <20121202234110.GM12509@titan.lakedaemon.net> <20121209184004.GC28052@1wt.eu>
 <20130107174831.GN5075@titan.lakedaemon.net> <20130107180849.GA28008@1wt.eu>
 <20130107181731.GQ5075@titan.lakedaemon.net>
Message-ID: <20130107182031.GB28008@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 07, 2013 at 01:17:31PM -0500, Jason Cooper wrote:
> mach-mvebu is where everything is being migrated to once the DT
> conversion is complete.  We use the name internally to refer to any SoCs
> created by Marvell in the EBU division.
> 
> So, yes, it's kirkwood, but it falls under mvebu stuff.  Just like dove
> and orion5x.

OK, that was not obvious to me, since till now for me mvebu was only
the new armada370/XP boards. But that makes sense and it will certainly
make code sharing easier !

Thanks for your explanation!

Willy
