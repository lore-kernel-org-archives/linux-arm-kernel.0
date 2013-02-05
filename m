From: tony@atomide.com (Tony Lindgren)
Date: Tue, 5 Feb 2013 10:56:48 -0800
Subject: [PATCH] ARM:omap2: using strlcpy instead of strncpy
In-Reply-To: <51106BF2.7080203@asianux.com>
References: <51090829.1010109@asianux.com> <20130201224546.GG22517@atomide.com>
 <510F78AB.4000602@ti.com> <20130204181844.GP22517@atomide.com>
 <51106BF2.7080203@asianux.com>
Message-ID: <20130205185648.GM25185@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Chen Gang <gang.chen@asianux.com> [130204 18:22]:
> ? 2013?02?05? 02:18, Tony Lindgren ??:
> > * Peter Ujfalusi <peter.ujfalusi@ti.com> [130204 01:04]:
> >> > Hi Tony,
> >> > 
> >> > I can create a branch for you in our gitorious tree
> >> > (git://gitorious.org/omap-audio/linux-audio.git) for this patch. But I think
> >> > for now it would be best if you could take this via linux-omap (the file is
> >> > under arch/arm/mach-omap2 anyways)
> > OK thanks I'll apply with your ack to omap-for-v3.9/fixes-noncritical.
> > 
> > Tony
> > 
> 
>   Does it mean: we need not sync MAINTAINERS file for twl-*, recently ?
> 
>   :-)

No we should still do it.

Tony
