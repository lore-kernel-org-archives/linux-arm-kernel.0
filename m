From: khilman@ti.com (Kevin Hilman)
Date: Tue, 29 Mar 2011 10:41:48 -0700
Subject: [PATCH 03/10] omap: Move dmtimer defines to dmtimer.h
In-Reply-To: <20110328222134.4046.53842.stgit@baageli.muru.com> (Tony
	Lindgren's message of "Mon, 28 Mar 2011 15:21:35 -0700")
References: <20110328221501.4046.41079.stgit@baageli.muru.com>
	<20110328222134.4046.53842.stgit@baageli.muru.com>
Message-ID: <87mxkdygbn.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

[...]

> diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
> index 330bd17..66c4b34 100644
> --- a/arch/arm/plat-omap/include/plat/dmtimer.h
> +++ b/arch/arm/plat-omap/include/plat/dmtimer.h
> @@ -92,5 +92,130 @@ void omap_dm_timer_write_counter(struct omap_dm_timer *timer, unsigned int value
>  
>  int omap_dm_timers_active(void);
>  
> +/*
> + * Do not the defines below, they are not needed. They should be only

Do not what?    ;)

Kevin
