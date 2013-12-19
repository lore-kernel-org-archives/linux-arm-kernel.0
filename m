From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 19 Dec 2013 13:01:36 -0500
Subject: Can someone Ack and queue a patch for RTC subsytem?
In-Reply-To: <20131219184024.2a649328@linux.lan.towertech.it>
References: <87siton6ke.fsf@natisbad.org>
 <20131219173857.0a546b99@linux.lan.towertech.it>
 <87d2kslphr.fsf@natisbad.org>
 <20131219184024.2a649328@linux.lan.towertech.it>
Message-ID: <20131219180136.GX2609@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 06:40:24PM +0100, Alessandro Zummo wrote:
> On Thu, 19 Dec 2013 18:28:16 +0100 arno at natisbad.org (Arnaud Ebalard) wrote:
> > At some point, Alessandro Zummo wrote:
...
> > > I do not maintain a separate tree due to most RTCs being specifit to a
> > > subsytem.   
> > 
> > I do not understand: the chip is generic, i.e. this is not a RTC chip
> > specific to a given SoC (like rtc-mv.c is for instance). Can you be
> > more specific?
> 
>  Yes, this chip is generic, but most aren't. Some of those who
>  are generic, are strictly connected to a particular system/board, 
>  and they end up in that system's tree. Most of the drivers
>  are pretty small.

That goes against the whole goal of the arm-soc devicetree conversion.
For the past several years, we've been moving drivers _out_ of arch/arm/
into the appropriate drivers/ area.  The goal of this was to unclutter
arch/arm/, and to more readily see and remove code duplication by
drivers.

thx,

Jason.
