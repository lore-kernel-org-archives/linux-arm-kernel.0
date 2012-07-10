From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 10 Jul 2012 19:23:41 +0200
Subject: Add basic device tree support for i.MX31 (and for a machine
 using it)
In-Reply-To: <1341862753-14848-1-git-send-email-GNUtoo@no-log.org>
References: <1341862753-14848-1-git-send-email-GNUtoo@no-log.org>
Message-ID: <20120710172341.GD30009@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 09, 2012 at 09:39:11PM +0200, Denis 'GNUtoo' Carikli wrote:
> Hi,
> 
> The following two patches add very basic device tree support for
>  the i.MX31 and the buglabs's bug 1.x machine.
> 
> The i.MX31 patch was only tested on the buglabs bug 1.x because
>   I only have two almost identical(the only difference is 
>   that the one(the 1.3 version) has a libertas_sdio compatible 
>   wifi+bluetooth chip) bug 1.x as i.MX31 machine.
> 
> Because of that only the uart5 was tested.

Applied, thanks

Sascha

> 
> Denis.
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
