From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Sep 2012 08:05:54 +0000
Subject: [PATCH 02/24] ARM: at91: use __iomem pointers for MMIO
In-Reply-To: <5056D794.5000107@atmel.com>
References: <1347658492-11608-1-git-send-email-arnd@arndb.de>
 <1347658492-11608-3-git-send-email-arnd@arndb.de>
 <5056D794.5000107@atmel.com>
Message-ID: <201209180805.55175.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 September 2012, Nicolas Ferre wrote:
> > @@ -94,7 +94,7 @@ static const u32 uarts_sam9x5[] = {
> >       0,
> >  };
> >  
> > -static inline const u32* decomp_soc_detect(u32 dbgu_base)
> > +static inline const u32* decomp_soc_detect(void __iomem*dbgu_base)
> 
> A whitespace is missing before the *, no?
> 

Fixed now, thanks!

	Arnd
