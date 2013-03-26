From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Mar 2013 22:12:31 +0000
Subject: [PATCH v6 0/7] move s3c24xx-irq to drivers/irqchip and add dt
 support
In-Reply-To: <201303262305.49725.heiko@sntech.de>
References: <201303262305.49725.heiko@sntech.de>
Message-ID: <201303262212.31283.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 March 2013, Heiko St?bner wrote:
> This v6 addresses more comments from Arnd Bergmann, setting the compatible
> property to the first supported SoC (s3c2410) instead of using the s3c24xx
> wildcard. It also switches the parent-irq and controller irq in the dt
> irq descriptor bringing it to a format of
> 
>   <ctrl_num parent_irq ctrl_irq type>

Entire series

Acked-by: Arnd Bergmann <arnd@arndb.de>
