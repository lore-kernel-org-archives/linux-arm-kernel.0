From: ryan@bluewatersys.com (Ryan Mallon)
Date: Wed, 21 Oct 2009 13:58:45 +1300
Subject: [PATCH] ep93xx: remove ep93xx_init_time() prototype
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901DB8075@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE190901DB8075@mi8nycmail19.Mi8.com>
Message-ID: <4ADE5CC5.3070807@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

H Hartley Sweeten wrote:
> Remove unused prototype for ep93xx_init_time().  This function
> is not defined in the kernel.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <ryan@bluewatersys.com>
> 
> ---
> 
> diff --git a/arch/arm/mach-ep93xx/include/mach/platform.h b/arch/arm/mach-ep93xx/include/mach/platform.h
> index a3ec33f..469fd96 100644
> --- a/arch/arm/mach-ep93xx/include/mach/platform.h
> +++ b/arch/arm/mach-ep93xx/include/mach/platform.h
> @@ -17,7 +17,6 @@ struct ep93xx_eth_data
>  
>  void ep93xx_map_io(void);
>  void ep93xx_init_irq(void);
> -void ep93xx_init_time(unsigned long);
>  
>  /* EP93xx System Controller software locked register write */
>  void ep93xx_syscon_swlocked_write(unsigned int val, void __iomem *reg); 
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
