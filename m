From: ryan@bluewatersys.com (Ryan Mallon)
Date: Thu, 18 Feb 2010 14:53:42 +1300
Subject: [PATCH] ep93xx: include correct irq.h in core.c
In-Reply-To: <201001141353.23018.hartleys@visionengravers.com>
References: <201001141353.23018.hartleys@visionengravers.com>
Message-ID: <4B7C9DA6.1090100@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

H Hartley Sweeten wrote:
> ep93xx: include correct irq.h in core.c
> 
> Currently <asm/mach/irq.h> is included by core.c. This header
> includes <linux/irq.h> and defines a number of internal functions.
> These internal functions are not needed by this file. Change the
> include so that we just get what is needed.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <ryan@bluewatersys.com>

Acked-by: Ryan Mallon <ryan@bluewatersys.com>

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
