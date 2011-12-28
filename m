From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 28 Dec 2011 18:51:35 +0100
Subject: Renaming MACH_TYPE_KINETIS_K60 into MACH_TYPE_KINETIS
In-Reply-To: <1325069504.1584.160.camel@skywanderer.emcraft.com>
References: <1325065882.1584.153.camel@skywanderer.emcraft.com>
 <201112281100.35209.marek.vasut@gmail.com>
 <1325069504.1584.160.camel@skywanderer.emcraft.com>
Message-ID: <201112281851.35717.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Wed, 2011-12-28 at 11:00 +0100, Marek Vasut wrote:
> > If you use FDT, you won't need machine ID at all.
> 
> Hi Marek,
> 
> You are right, but we have not used FDT for any of our ARM Linux ports
> yet (consistency matters.) If we switch to FDT now, a lot of code will
> need to be rewritten.
> 
> That is why I would prefer to stay with machine type-based
> identification.

Well ... you probably do, let's see about the others ;-)
