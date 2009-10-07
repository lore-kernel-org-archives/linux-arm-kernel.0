From: ryan@bluewatersys.com (Ryan Mallon)
Date: Thu, 08 Oct 2009 10:36:44 +1300
Subject: [PATCH] ep93xx: remove old EP93XX_GPIO_* defines
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901DB7AFF@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE190901DB7AFF@mi8nycmail19.Mi8.com>
Message-ID: <4ACD09EC.1000701@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

H Hartley Sweeten wrote:
> Most of the EP93XX_GPIO_*_INT_* register defines in ep93xx-regs.h
> not required due to how the ep93xx core and gpiolib support handle
> gpio interrupts.  Remove the defines to prevent future confusion.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <ryan@bluewatersys.com>

Acked-by: Ryan Mallon <ryan@bluewatersys.com>

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
