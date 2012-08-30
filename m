From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 30 Aug 2012 17:01:18 -0400 (EDT)
Subject: [PATCH 0/6] Integrator devicetree support
In-Reply-To: <alpine.LFD.2.02.1208191148520.1754@xanadu.home>
References: <1345119317-22600-1-git-send-email-linus.walleij@linaro.org>
 <201208161344.55723.arnd@arndb.de>
 <CACRpkdYYgdzAU=nyL7dQbdMLx3z3G+K7ba0uJe1=aX=BLeF_sg@mail.gmail.com>
 <alpine.LFD.2.02.1208191148520.1754@xanadu.home>
Message-ID: <alpine.LFD.2.02.1208301659070.1784@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 19 Aug 2012, Nicolas Pitre wrote:

> On Sun, 19 Aug 2012, Linus Walleij wrote:
> 
> > But then we hit #ifdeffing and compiling out a lot of dangerous stuff
> > in arch/arm/kernel and then I get the creeps. I can try, but I think
> > this is typical Nico territory for example...
> 
> I did post a patch moving all the ATAG stuff to a separate source file a 
> while ago, exactly for that purpose.  I should try to dig it out and 
> refresh it.

OK... In this case "a while ago" = 2 years!

Please see the 2 patches to follow.


Nicolas
