From: Peter.Chen@freescale.com (Peter Chen)
Date: Thu, 26 Feb 2015 09:18:24 +0000
Subject: [PATCH v2 0/2] ARM: imx6sx-sdb: add revb board
In-Reply-To: <20150226075838.GF20028@dragon>
References: <1421804094-26379-1-git-send-email-peter.chen@freescale.com>
 <20150226075838.GF20028@dragon>
Message-ID: <BN3PR0301MB084995583E88A7A53E5D5A0F81140@BN3PR0301MB0849.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


 
> >
> > The main changes between reva and revb board:
> > - OOP setting
> > - pfuse
> > - qspi
> > - can transceiver (not mainlined)
> >
> > Changes for v2:
> >
> > - Add missing Makefile entries for both dts files. [Patch 1/2] and
> > [Patch 2/2]
> > - Delete OOP setting changed at imx6sx-sdb-reva, it is SoC feature,
> >   it doesn't need to be change unless board limitations. [Patch 1/2]
> > - Add explanation why OOP setting need to changed at imx6sx-sdb revb
> > board. [Patch 2/2]
> > - Make imx6sx-sdb revb board as default imx6sx-sdb board. [Patch 2/2]
> >
> > Peter Chen (2):
> >   ARM: imx6sx-sdb: change default board as reva board
> >   ARM: imx6sx-sdb: add revb board and make it default
> 
> Peter,
> 
> What branch did you generate these patches on?  I'm trying to apply them, but
> they do not apply on any reasonable branch.  Can you re-spin against v4.0-rc1?
> Thanks.
> 

I did it based on two or three weeks Linux-next tree, I will send it based on
v4.0-rc1 today.

Peter
