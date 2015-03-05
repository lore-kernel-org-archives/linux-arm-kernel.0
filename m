From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 5 Mar 2015 20:47:39 +0100
Subject: [PATCH v4 6/9] ARM: at91: time: move the system timer driver to
 drivers/clocksource
In-Reply-To: <1425584493.24292.236.camel@x220>
References: <1425570594-13124-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1425570594-13124-7-git-send-email-alexandre.belloni@free-electrons.com>
 <1425584493.24292.236.camel@x220>
Message-ID: <20150305194739.GZ3989@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/03/2015 at 20:41:33 +0100, Paul Bolle wrote :
> On Thu, 2015-03-05 at 16:49 +0100, Alexandre Belloni wrote:
> > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> > index 1c2506f68122..d1d15985a4ec 100644
> > --- a/drivers/clocksource/Kconfig
> > +++ b/drivers/clocksource/Kconfig
> > @@ -138,6 +138,10 @@ config ATMEL_PIT
> >  	select CLKSRC_OF if OF
> >  	def_bool SOC_AT91SAM9 || SOC_SAMA5
> >  
> > +config ATMEL_ST
> > +	select CLKSRC_OF if OF
> > +	def_bool SOC_AT91RM9200
> 
> If you swap these two lines you'll make the set of people that probably
> only includes me a bit happier.
> 

I'm all for making you happier ;)

I'll respin next week, hopefully after getting more comments.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
