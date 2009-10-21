From: ryan@bluewatersys.com (Ryan Mallon)
Date: Wed, 21 Oct 2009 14:10:45 +1300
Subject: [PATCH] ep93xx: add keypad core support
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901DB7CE7@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE190901DB7CE7@mi8nycmail19.Mi8.com>
Message-ID: <4ADE5F95.8060504@bluewatersys.com>
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
> Note: this patch will need to be rebased once a few patches in
> the ARM patch tracker are applied.  Please consider this patch
> for review.

The patch looks okay. Can you do the rebase and repost it please. I want
to at least build test non-trivial patches from now on to avoid silly
build error bugs getting introduced again.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
