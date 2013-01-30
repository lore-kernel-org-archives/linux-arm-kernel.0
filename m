From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 30 Jan 2013 16:15:52 -0700
Subject: [PATCH v2 1/2] ARM: kirkwood: Ensure that
 kirkwood_ge0[01]_init() finds its clock
In-Reply-To: <20130130230100.GV7717@titan.lakedaemon.net>
References: <20130127152431.GX1758@titan.lakedaemon.net>
 <20130128223148.GA10275@schnuecks.de>
 <20130129004824.GB7717@titan.lakedaemon.net>
 <20130129194243.GA30831@schnuecks.de> <51082C4E.5050903@gmail.com>
 <20130130000341.GA10600@schnuecks.de> <51086E86.8040705@gmail.com>
 <20130130083044.GA25688@schnuecks.de> <5108F300.7000705@gmail.com>
 <20130130230100.GV7717@titan.lakedaemon.net>
Message-ID: <20130130231552.GA7915@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 06:01:00PM -0500, Jason Cooper wrote:

> Once we add proper DT support to mv643xx_eth, the local-mac-address will
> need to be defined in the dtb.  We should probably poke the other Jason
> to see if there is a cooresponding u-boot patch to his local-mac-address
> patch.

Sorry I don't have a u-boot fix, we don't use u-boot here - but
local-mac-address is common on other ARM drivers so I'd hope there is
a u-boot facility for stuffing it already?

Jason
