From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sun, 19 Aug 2012 11:52:32 -0400 (EDT)
Subject: [PATCH 0/6] Integrator devicetree support
In-Reply-To: <CACRpkdYYgdzAU=nyL7dQbdMLx3z3G+K7ba0uJe1=aX=BLeF_sg@mail.gmail.com>
References: <1345119317-22600-1-git-send-email-linus.walleij@linaro.org>
 <201208161344.55723.arnd@arndb.de>
 <CACRpkdYYgdzAU=nyL7dQbdMLx3z3G+K7ba0uJe1=aX=BLeF_sg@mail.gmail.com>
Message-ID: <alpine.LFD.2.02.1208191148520.1754@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 19 Aug 2012, Linus Walleij wrote:

> But then we hit #ifdeffing and compiling out a lot of dangerous stuff
> in arch/arm/kernel and then I get the creeps. I can try, but I think
> this is typical Nico territory for example...

I did post a patch moving all the ATAG stuff to a separate source file a 
while ago, exactly for that purpose.  I should try to dig it out and 
refresh it.


Nicolas
