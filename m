From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 29 Sep 2012 22:53:55 +0100
Subject: ARM SoC tree, Was: Re: [PATCH 05/12] ARM: ixp4xx: use __iomem
 for MMIO
In-Reply-To: <m3pq54jyqw.fsf@intrepid.localdomain>
References: <1348868177-21205-1-git-send-email-arnd@arndb.de>
 <1348868177-21205-6-git-send-email-arnd@arndb.de>
 <m3lift6rru.fsf_-_@intrepid.localdomain> <201209291458.16112.arnd@arndb.de>
 <m3y5jskbir.fsf@intrepid.localdomain>
 <20120929174400.GA6933@n2100.arm.linux.org.uk>
 <m3pq54jyqw.fsf@intrepid.localdomain>
Message-ID: <20120929215355.GD6933@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 29, 2012 at 11:38:31PM +0200, Krzysztof Halasa wrote:
> Note I'm not only doing ARM, but also X86 and MIPS, with additional code
> shared between them, and the "stable" part of it is what I'm paid for.
> I can't simply work with arm-soc, none of my platforms will even boot
> with pure arm-soc.

I'm assuming that Linus' -rc kernels work for you, yes?

So, that suggests there's something in arm-soc which is breaking your
platforms, which means that you'll need to cook up a fix after or
during the next merge window.

You could instead cook that fix up _now_ before the merge window and
have it ready, _or_ send the fix to arm-soc or even report the regression
so that we don't end up with IXP4xx breaking at the next merge window.
