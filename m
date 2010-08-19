From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Aug 2010 13:04:11 +0200
Subject: [PATCHv2 2/1] Consolidate CONFIG_DEBUG_STRICT_USER_COPY_CHECKS
In-Reply-To: <20100819144719.e690c674.sfr@canb.auug.org.au>
References: <201008181428.45029.arnd@arndb.de>
	<1282184898-30599-1-git-send-email-sboyd@codeaurora.org>
	<20100819144719.e690c674.sfr@canb.auug.org.au>
Message-ID: <201008191304.11190.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 19 August 2010, Stephen Rothwell wrote:
>   On Wed, 18 Aug 2010 19:28:18 -0700 Stephen Boyd <sboyd@codeaurora.org> wrote:
> >
> > +config ARCH_HAS_DEBUG_STRICT_USER_COPY_CHECKS
> > +     def_bool y
> 
> Why not just have
> 
> config ARCH_HAS_DEBUG_STRICT_USER_COPY_CHECKS
>         bool
> 
> in lib/Kconfig.debug
> 
> and select that in each arch that want it?
> 

Yes, that would be even easier, thanks for the suggestion!

	Arnd
