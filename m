From: tony@atomide.com (Tony Lindgren)
Date: Tue, 8 May 2012 15:17:20 -0700
Subject: [PATCH 0/2] ARM: OMAP3: cleanup AM35xx SoC detection
In-Reply-To: <8762c6mkyc.fsf@ti.com>
References: <1335829030-19431-1-git-send-email-khilman@ti.com>
 <87zk9j5216.fsf@ti.com> <20120508205822.GF5088@atomide.com>
 <8762c6mkyc.fsf@ti.com>
Message-ID: <20120508221720.GN5088@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@ti.com> [120508 14:20]:
> 
> This last "removal" patch depends on the am35x clock changes that are in
> devel-prcm too.  So in order to apply it, I'd need a stable base with
> your cleanup and devel-prcm branches.
> 
> It's not a big deal though, it can wait until v3.5 as well.

OK let's avoid adding more dependencies if possible.. If it just
removes stuff, let's do it at the end of the merge window, or
at v3.5-rc1.

Regards,

Tony
