From: ryan@bluewatersys.com (Ryan Mallon)
Date: Tue, 06 Oct 2009 11:13:39 +1300
Subject: [PATCH] Change ep93xx gpio_irq static inlines to macros
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901DB7762@mi8nycmail19.Mi8.com>
References: <49EBDE05.1050406@bluewatersys.com>
	<BD79186B4FD85F4B8E60E381CAEE190901DB7762@mi8nycmail19.Mi8.com>
Message-ID: <4ACA6F93.1090204@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

H Hartley Sweeten wrote:
> From: Ryan Mallon <ryan@bluewatersys.com>
> 
> Change the gpio_to_irq and irq_to_gpio static inline functions to macros
> so that they can be used in variable initialisers.
> 
> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
> Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> 
> ---
> 
> This patch seems to have been lost, originally posted 4/19/2009.
> Updated so that the macro parameters are wrapped with ().
>  

Thanks Hartley. I think this patch should still be okay, I don't think
anything relies on these being functions.

Can you please submit to the patch system since you have the patch ready
to go.

Thanks,
~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
