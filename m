From: dtrautmann@ibhsoftec.com (Daniel Trautmann)
Date: Fri, 18 Dec 2015 11:20:21 +0100
Subject: [PATCH v2 0/3] drivers: net: cpsw: Fix bugs in fixed-link PHY DT
 parsing
In-Reply-To: <20151217.154508.505711333985621252.davem@davemloft.net>
References: <20151209223115.6c5a400f.drivshin.allworx@gmail.com>
 <1741588.Ve76Z1ZI87@localhost>
 <cover.1450309613.git.drivshin@allworx.com>
 <20151217.154508.505711333985621252.davem@davemloft.net>
Message-ID: <20151218102020.GA1703@dt-ub1404lts.ENTWDOM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 17, 2015 at 03:45:08PM -0500, David Miller wrote:
> From: "David Rivshin (Allworx)" <drivshin.allworx@gmail.com>
> Date: Wed, 16 Dec 2015 23:02:08 -0500
> 
> > I have tested on the following hardware configurations:
> >  - (EVMSK) dual emac with two real MDIO-connected phys using RGMII-TXID
> >  - single emac with fixed-link using RGMII
> > Testing of other CPSW emac configurations that folks may have would
> > be appreciated.
> 
> I'm going to wait until some others give some feedback and testing
> results on this one, thanks.

I can confirm that this patch is working on the following hardware setup:
 - single emac using MII connected with fixed-link to Micrel KSZ8895 Switch
