From: marex@denx.de (Marek Vasut)
Date: Mon, 16 Jul 2012 12:59:14 +0200
Subject: [PATCH 04/10 RESEND] mmc: spi: Pull out parts shared between MMC
 and SPI
In-Reply-To: <20120716095741.85d959fc81ab759b10adcf25@kinali.ch>
References: <1341555449-17507-1-git-send-email-marex@denx.de>
 <1341555449-17507-4-git-send-email-marex@denx.de>
 <20120716095741.85d959fc81ab759b10adcf25@kinali.ch>
Message-ID: <201207161259.15034.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Attila Kinali,

> Moin,
> 
> I just wanted to try out this patchset as i have a use for proper spi
> support on i.mx23. But this patch (4/10) fails to apply at line 635
> 
[...]

> > +	struct mxs_ssp *ssp;
> > 
> >  	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >  	dmares = platform_get_resource(pdev, IORESOURCE_DMA, 0);
> 
> The function variables do not match.
> 
> Also a 3way merge didnt work as the comit on which this patchset was
> based on wasnt found. I tried linux, linux-next, and the imx repos
> from pengutronix and Shawn, to no avail.
> 
> Is there any other repo around that i'm not aware of?
> 
> 			Attila Kinali

Well I have it rebased on top of current -next, but ... will some of the SPI 
maintainers possibly apply it to their -next tree any soon? Or why are these 
patches stuck as they are without much review ?

It seems Shawn is OK with the latest version, so can these be applied? I'll post 
the rebased version again if necessary.

Best regards,
Marek Vasut
