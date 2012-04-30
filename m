From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Mon, 30 Apr 2012 22:48:30 +0200
Subject: [PATCH] maintainership update for the Marvell Orion family of SOCs
In-Reply-To: <alpine.LFD.2.02.1204301330111.21030@xanadu.home> (Nicolas
 Pitre's message of "Mon, 30 Apr 2012 13:44:48 -0400 (EDT)")
References: <alpine.LFD.2.02.1204301330111.21030@xanadu.home>
Message-ID: <87wr4x9c9t.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Nicolas Pitre <nico@fluxnic.net> writes:
> While Lennert and I have moved our focus to other things, some people
> picked up the slack on those platforms.  Let's empower them with a more 
> official status.
>
> Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
> Cc: Lennert Buytenhek <kernel@wantstofly.org>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bb76fc42fc..348b881f74 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -908,11 +908,12 @@ ARM/MAGICIAN MACHINE SUPPORT
>  M:	Philipp Zabel <philipp.zabel@gmail.com>
>  S:	Maintained
>  
> -ARM/Marvell Loki/Kirkwood/MV78xx0/Orion SOC support
> -M:	Lennert Buytenhek <kernel@wantstofly.org>
> -M:	Nicolas Pitre <nico@fluxnic.net>
> +ARM/Marvell Dove/Kirkwood/MV78xx0/Orion SOC support
> +M:	Jason Cooper <jason@lakedaemon.net>
> +M:	Andrew Lunn <andrew@lunn.ch>
>  L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> -S:	Odd Fixes
> +S:	Maintained
> +F:	arch/arm/mach-dove/
>  F:	arch/arm/mach-kirkwood/
>  F:	arch/arm/mach-mv78xx0/
>  F:	arch/arm/mach-orion5x/

Sorry to hijack a little bit this thread, but I got a few days ago a
88ap510/dove device so I was wondering if the work currently done on
kirkwood would allow us the same kernel binary at least on dove and
kirkwood ? [1] If so, when it'll be possible, will it be considered to
move the corresponding board setup from
arch/arm/mach-{dove,kirkwood,...} into a new directory, like what was
done on recently on imx ?

Thanks,
Arnaud

[1] I'm only talking of kirkwood and dove because it's only what I can
test. Of course, if it can be a single kernel binary for
dove/kirkwood/mv78xx0/orion5x, it'll be even better.
