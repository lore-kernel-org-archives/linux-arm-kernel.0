From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 19 Mar 2015 13:53:24 +0100
Subject: [PATCH] clocksource: atmel-st: select REGMAP_MMIO
In-Reply-To: <20150319090216.634797ef@bbrezillon>
References: <1426676795-29333-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20150319090216.634797ef@bbrezillon>
Message-ID: <20150319125324.GC4750@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/03/2015 at 09:02:16 +0100, Boris Brezillon wrote :
> > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> > index 168035883afa..3cc97b217019 100644
> > --- a/drivers/clocksource/Kconfig
> > +++ b/drivers/clocksource/Kconfig
> > @@ -146,6 +146,7 @@ config ATMEL_PIT
> >  config ATMEL_ST
> >  	bool
> >  	select CLKSRC_OF
> > +	select REGMAP_MMIO
> 
> Shouldn't we select MFD_SYSCON instead.
> 

Indeed, I'll send v2


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
