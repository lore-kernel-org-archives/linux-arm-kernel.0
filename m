From: marex@denx.de (Marek Vasut)
Date: Tue, 9 Oct 2012 19:10:45 +0200
Subject: [PATCH] mmc: mxs: fix build regression from mismerge
In-Reply-To: <877gqzabjy.fsf@octavius.laptop.org>
References: <201210091537.23659.arnd@arndb.de>
 <877gqzabjy.fsf@octavius.laptop.org>
Message-ID: <201210091910.45992.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Chris Ball,

> Hi,
> 
> On Tue, Oct 09 2012, Arnd Bergmann wrote:
> > From all I can tell, the patches
> > 
> > fc108d24 "mmc: mxs-mmc: fix deadlock caused by recursion loop"
> > 829c1bf4 "mmc: spi: Pull out parts shared between MMC and SPI"
> > 
> > came in through separate branches and cause this build error when
> > combined.
[...]

> 
> I'll send Marek's change to Linus once the main MMC merge has been pulled.
> Thanks,
> 
> - Chris.

Thanks! Sorry from my previous reply from Android phone, I just saw what 
horrible email it generated :-(

Best regards,
Marek Vasut
