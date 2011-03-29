From: tony@atomide.com (Tony Lindgren)
Date: Tue, 29 Mar 2011 10:44:57 -0700
Subject: [PATCH 03/10] omap: Move dmtimer defines to dmtimer.h
In-Reply-To: <87mxkdygbn.fsf@ti.com>
References: <20110328221501.4046.41079.stgit@baageli.muru.com>
	<20110328222134.4046.53842.stgit@baageli.muru.com>
	<87mxkdygbn.fsf@ti.com>
Message-ID: <20110329174457.GL4016@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@ti.com> [110329 10:39]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> [...]
> 
> > diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
> > index 330bd17..66c4b34 100644
> > --- a/arch/arm/plat-omap/include/plat/dmtimer.h
> > +++ b/arch/arm/plat-omap/include/plat/dmtimer.h
> > @@ -92,5 +92,130 @@ void omap_dm_timer_write_counter(struct omap_dm_timer *timer, unsigned int value
> >  
> >  int omap_dm_timers_active(void);
> >  
> > +/*
> > + * Do not the defines below, they are not needed. They should be only
> 
> Do not what?    ;)

Looks like the nasty parts got censored ;) Should say "Do not use".

Tony
