From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 19 Oct 2012 12:25:08 -0400
Subject: [PULL REQ] IXP4xx changes for Linux 3.7
In-Reply-To: <m3a9vkahci.fsf@intrepid.localdomain>
References: <m3bog6m5iz.fsf@intrepid.localdomain>
 <201210142002.55841.arnd@arndb.de>
 <m3a9vkahci.fsf@intrepid.localdomain>
Message-ID: <20121019162508.GJ14395@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 18, 2012 at 12:01:17AM +0200, Krzysztof Halasa wrote:
...
> Unfortunately, as I already explained to you in
> https://lkml.org/lkml/2012/9/29/37, my resources for IXP4xx are very
> limited (and this isn't a paid job) and I'm in no way able to do what
> you require. This, coupled with my inability to make the patches end
> up upstream any other way, will make me post relevant MAINTAINERS
> changes shortly.
> 
> Don't get me wrong. If I had time for this it could be different.
> Unfortunately IXP4xx is a legacy arch, and for me it's simply a hobby
> at this point. Given the raised barriers to participate, probably
> aimed at paid maintainers, I have to quit doing this.

Krzysztof, please reconsider.  I'm also a hobbyist maintainer
(kirkwood,orion5x,mv78xx0,dove,mvebu).  I'd hate to see the community
lose a valuable maintainer because arch/arm/ has grown so much.

If you would like, I could pull your patches through my tree and send
them on to arm-soc.  I'm already familiar with arm-soc process, and I'll
admit I have a soft spot for mach-ixp4xx.  It was my first experience
with embedded Linux (nslu2, gateworks boards).

This way, you could see the process first hand without having to do the
labor.

We could do this for a few release cycles so you can see how it goes.
After that, we can reassess things.  If you still don't wish to lend
your experience, so be it.  But I hope we can change your mind.

thx,

Jason.
