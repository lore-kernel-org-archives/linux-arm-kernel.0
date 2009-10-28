From: ryan@bluewatersys.com (Ryan Mallon)
Date: Thu, 29 Oct 2009 08:49:02 +1300
Subject: [PATCH] ep93xx: add keypad core support
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901E24CDA@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE190901DB7CE7@mi8nycmail19.Mi8.com>	<4ADE5F95.8060504@bluewatersys.com>
	<BD79186B4FD85F4B8E60E381CAEE190901E24CDA@mi8nycmail19.Mi8.com>
Message-ID: <4AE8A02E.1030203@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

H Hartley Sweeten wrote:
> Add the core support needed by the ep93xx matrix keypad driver.
> 
> The keypad driver unfortunately was merged early and the core
> support is missing.  The clkdev support has been resolved and
> is now merged.  This adds the platform device to the ep93xx
> core and supplies the functions needed to acquire/free the gpio
> pins and actually enable/disable the controller peripheral.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <ryan@bluewatersys.com>
> 
> ---
> 
> V2 - rebased to current arm-git
> 

Acked-by: Ryan Mallon <ryan@bluewatersys.com>

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
