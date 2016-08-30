From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 30 Aug 2016 17:36:49 +0200
Subject: Older hisilicon chipsets
In-Reply-To: <20160830145843.GS10637@io.lakedaemon.net>
References: <7773f0e5-d045-1e93-529b-74a601467ed1@gmail.com>
 <7d7ff37b-a16b-8532-214c-de0a46c9de8e@gmail.com>
 <20160830145843.GS10637@io.lakedaemon.net>
Message-ID: <201608301736.49102.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 30 August 2016, Jason Cooper wrote:
> On Tue, Aug 30, 2016 at 09:43:52AM -0500, Marty Plummer wrote:
> > Hi Wei,
> > 
> > Do you think you could change the references to the Hi3620 in the code
> > and dts files from `hi3xxx' to `hi3620'? As it currently stands, the
> > wildcard matches hi3520 too, but that's not a good idea whit devicetree,
> > its best to be completely explicit as to which sort of device the
> > binding is for.
> 
> Please submit a patch, there shouldn't be wildcards in devicetree
> compatible strings. :-/

Fortunately, I don't see wildcards in the dts files, I think we were
careful enough here. The Linux-internal identifiers and file names
are easily renamed, unlike the DT bindings.

	Arnd
