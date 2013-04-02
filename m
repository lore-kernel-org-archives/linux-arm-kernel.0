From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 02 Apr 2013 17:17:00 +0900
Subject: [PATCH v6 0/7] move s3c24xx-irq to drivers/irqchip and add dt
 support
In-Reply-To: <201303262212.31283.arnd@arndb.de>
References: <201303262305.49725.heiko@sntech.de>
 <201303262212.31283.arnd@arndb.de>
Message-ID: <22c901ce2f7a$731fe9f0$595fbdd0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:
> 
> On Tuesday 26 March 2013, Heiko St?bner wrote:
> > This v6 addresses more comments from Arnd Bergmann, setting the
> compatible
> > property to the first supported SoC (s3c2410) instead of using the
> s3c24xx
> > wildcard. It also switches the parent-irq and controller irq in the dt
> > irq descriptor bringing it to a format of
> >
> >   <ctrl_num parent_irq ctrl_irq type>
> 
> Entire series
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks.

Applied this whole series.

- Kukjin
