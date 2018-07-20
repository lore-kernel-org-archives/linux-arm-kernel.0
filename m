From: jmkrzyszt@gmail.com (Janusz Krzysztofik)
Date: Fri, 20 Jul 2018 19:57:12 +0200
Subject: [RFC PATCH 1/8] mtd: rawnand: ams-delta: Use private structure
In-Reply-To: <20180719081728.46eb7ab5@bbrezillon>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
 <20180718235710.18242-2-jmkrzyszt@gmail.com>
 <20180719081728.46eb7ab5@bbrezillon>
Message-ID: <1763213.HC3d3VW7aF@z50>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, July 19, 2018 8:17:28 AM CEST Boris Brezillon wrote:
> On Thu, 19 Jul 2018 01:57:03 +0200
> Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> 
> > Introduce a driver private structure and allocate it on device probe.
> > Use it for storing nand_chip structure, GPIO descriptors prevoiusly
> > stored in static variables as well as io_base pointer previously passed
> > as nand controller data or platform driver data.
> 
> That's a good thing. Thanks for doing that.
> 
> > Subsequent patches
> > may populate the structure with more members as needed.
> > 
> > While at it, fix missing mtd->dev.parent and drop useless mtd->owner.
> 
> I'd prefer to have it done in a separate patch if you don't mind.

No problem, I'll split it.

Thanks,
Janusz
