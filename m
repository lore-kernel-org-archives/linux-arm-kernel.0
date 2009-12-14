From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 14 Dec 2009 07:24:36 +0100
Subject: GPIO support for HTC Dream
In-Reply-To: <20091211232838.GE12628@n2100.arm.linux.org.uk>
References: <20091208102842.GH12264@elf.ucw.cz>
	<4B1EB57D.6070408@bluewatersys.com>
	<20091208214658.GC4164@elf.ucw.cz>
	<4B1ECEEE.3000209@bluewatersys.com>
	<4B203575.6050407@bluewatersys.com>
	<20091210172458.GJ19454@elf.ucw.cz>
	<4B2150B7.3040207@bluewatersys.com>
	<BD79186B4FD85F4B8E60E381CAEE190901FB0F92@mi8nycmail19.Mi8.com>
	<20091211221015.GB24456@elf.ucw.cz>
	<20091211232838.GE12628@n2100.arm.linux.org.uk>
Message-ID: <20091214062436.GJ5114@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2009-12-11 23:28:38, Russell King - ARM Linux wrote:
> On Fri, Dec 11, 2009 at 11:10:15PM +0100, Pavel Machek wrote:
> > +#include <linux/gpio.h>
> ...
> > +#include <mach/gpio.h>
> ...
> > +#include <asm/gpio.h>
> 
> Emm, this is getting really silly.
> 
> include/linux/gpio.h:
>   
>   #ifdef CONFIG_GENERIC_GPIO
>   #include <asm/gpio.h>
>   #else
>   ...
>   #endif
> 
> arch/arm/include/asm/gpio.h:
> 
>   #include <mach/gpio.h>

Fixed, thanks.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
