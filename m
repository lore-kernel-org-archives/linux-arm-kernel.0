From: r.schwebel@pengutronix.de (Robert Schwebel)
Date: Thu, 29 Jul 2010 18:54:13 +0200
Subject: Some benchmarks on ARM
In-Reply-To: <20100702180257.GA8767@pengutronix.de>
References: <20100702180257.GA8767@pengutronix.de>
Message-ID: <20100729165413.GU20855@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 02, 2010 at 08:02:57PM +0200, Robert Schwebel wrote:
> We have recently made some benchmarks, in order to get a little bit
> better fealing about where ARM cpus are today, especially when it
> comes to the "recent" ones, and in comparism to the Atom.

Thanks to everyone who posted feedback!

An updated version of the article is now here:
http://www.pengutronix.de/development/kernel/arm-benchmarks-20100729_en.html

Changes:

- all kernels ported to 2.6.34
- Atom without -rt
- all kernel configs available
- all benchmark commandlines added
- more info about compilers and generated code
- info about memory types and bus widths

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
