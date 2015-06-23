From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 23 Jun 2015 16:52:00 -0000
Subject: [PATCH] Show proper respect for Heinrich Hertz by using the
 correct unit for frequency
In-Reply-To: <20150511131952.GD2067@n2100.arm.linux.org.uk>
References: <20150511131952.GD2067@n2100.arm.linux.org.uk>
Message-ID: <20150502145947.GA8156@xo-6d-61-c0.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> The SI unit of frequency is Hertz, named after Heinrich Hertz, and is
> given the symbol "Hz" to denote this.  "hz" is not the unit of frequency,
> and is in fact meaningless.
> 
> Fix arch/arm to correctly use "Hz", thereby acknowledging Heinrich Hertz
> contribution to the modern world.
> 

> --- a/arch/arm/mach-ixp4xx/include/mach/platform.h
> +++ b/arch/arm/mach-ixp4xx/include/mach/platform.h
> @@ -74,7 +74,7 @@ extern unsigned long ixp4xx_exp_bus_size;
>  /*
>   * Clock Speed Definitions.
>   */
> -#define IXP4XX_PERIPHERAL_BUS_CLOCK 	(66) /* 66Mhzi APB BUS   */ 
> +#define IXP4XX_PERIPHERAL_BUS_CLOCK 	(66) /* 66MHzi APB BUS   */ 
>  #define IXP4XX_UART_XTAL        	14745600
>  

Speaking about meaningless... What is MHzi supposed to mean?

ACK for the rest.
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
