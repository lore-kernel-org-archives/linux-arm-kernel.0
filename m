From: pieterg@gmx.com (pieterg)
Date: Fri, 9 Jul 2010 10:57:48 +0200
Subject: [PATCH 3/5] colibri-pxa300: add uart support
In-Reply-To: <20100709071604.GS17833@buzzloop.caiaq.de>
References: <201007081904.08769.pieterg@gmx.com>
	<20100709071604.GS17833@buzzloop.caiaq.de>
Message-ID: <201007091057.48989.pieterg@gmx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 09 July 2010 09:16:04 Daniel Mack wrote:
> So I'd suggest you do something similar for the pxa3xx modules and
> create a colibri-pxa3xx-evalboard.c or anything and put all baseboard
> specific code there. That would also imply moving code that already
> exists.

OK, I'll make the same split for the 3xx, I'll try to send a new patch 
series next week.

> The same counts for the I2C patch. Users of the module might not have
> I2C in use, and want to use the pins for other stuff.

The I2C init obeys kernelconfig, but indeed, it belongs to the (eval)board, 
in the new setup.

Rgds, Pieter
