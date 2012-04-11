From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Apr 2012 15:08:45 +0000
Subject: [PATCH V3 1/5] ARM: kirkwood: Basic support for DNS-320 and
 DNS-325
In-Reply-To: <20120411141118.GG14790@titan.lakedaemon.net>
References: <1332885255-8304-1-git-send-email-jm@lentin.co.uk>
 <op.wclrwkqi4cuzmg@gonzo.lentin.co.uk>
 <20120411141118.GG14790@titan.lakedaemon.net>
Message-ID: <201204111508.46143.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 April 2012, Jason Cooper wrote:
> > Thinking about it, MACH_DNSKW_DT would probably be best. Anything
> > more general, e.g. MACH_DLINK_DNS_DT, would also cover the
> > orion-based DNS-313/323/343. Presumably there will always be
> > differences between kirkwood and orion5x?
> 
> Hmm, Well, I think I would prefer MACH_DLINK_KIRKWOOD_DT,
> MACH_DLINK_ORION5X_DT.  This way, all the dtb's for a given manf/SoC are
> built in one go, and the correct board-dt file is built as well.
> 
> So, in my case, I would do MACH_GLOBALSCALE_KIRKWOOD_DT, and
> MACH_GLOBALSCALE_ARMADA_DT.
> 
> Grant, Arnd, sound sensible?

I think it's fine, I just don't spend too much time on the naming
when the goal is to eventually just have one config option for
all manufacturers.

	Arnd
