From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Jul 2012 19:28:15 +0000
Subject: [PATCH v4] arm: socfpga: Add initial support for Altera's SOCFPGA
 HW
In-Reply-To: <1342637611.13680.2.camel@dinh-ubuntu>
References: <20120718102507.GA11993@elf.ucw.cz>
 <201207181242.44326.arnd@arndb.de> <1342637611.13680.2.camel@dinh-ubuntu>
Message-ID: <201207181928.15404.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 July 2012, Dinh.Nguyen wrote:
> > For instance, this could be
> > 
> >       compatible = "altr,socfpga-stmmac", "st,stmmac-v12.3.45", "st,stmmac";
> > 
> > Looking at the driver, it seems that this should actually not be called
> > stmmac in the devicetree but rather dwmac, so better make it
> > 
> >       compatible = "altr,socfpga-stmmac", "snps,dwmac-4.567", "snps,dwmac";
> > 
> 
> Is there already work to update the bindings to reflect this change in
> stmmac driver? Or could I help with setting up some patches for it?

Please send a patch to update the bindings and the driver
to the netdev mailing list.

	Arnd
