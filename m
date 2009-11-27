From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 27 Nov 2009 09:05:54 +0100
Subject: [PATCH v2] mx27: Add basic support for Maxtrack i-MXT TD60
In-Reply-To: <37367b3a0911250252h746c2166n4eef27cf1046fbbe@mail.gmail.com>
References: <37367b3a0911241021u68ac346dmf30fc98f252b1d35@mail.gmail.com>
	<c70ff3ad0911241139g2b5b706fp936a009867ac7674@mail.gmail.com>
	<37367b3a0911250252h746c2166n4eef27cf1046fbbe@mail.gmail.com>
Message-ID: <20091127080554.GI27548@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2009 at 08:52:08AM -0200, Alan Carvalho de Assis wrote:
> Hi Saeed,
> 
> On 11/24/09, saeed bishara <saeed.bishara@gmail.com> wrote:
> >> ...
> >> +#include <mach/i2c.h>
> >> +#include <mach/imxfb.h>
> >> +#include <mach/mmc.h>
> >> +
> >> +#include "devices.h"
> >> +
> >> +static unsigned int mxt_td60_pins[] = {
> > shouldn't this be __initdata?
> 
> I think it could be used, but I don't see others MX27 boards using it.
> 
> Sascha, what you think?

Yes, it should be __initdata

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
