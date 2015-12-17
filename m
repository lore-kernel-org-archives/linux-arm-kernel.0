From: davem@davemloft.net (David Miller)
Date: Thu, 17 Dec 2015 15:45:08 -0500 (EST)
Subject: [PATCH v2 0/3] drivers: net: cpsw: Fix bugs in fixed-link PHY
 DT parsing
In-Reply-To: <cover.1450309613.git.drivshin@allworx.com>
References: <20151209223115.6c5a400f.drivshin.allworx@gmail.com>
 <1741588.Ve76Z1ZI87@localhost>
 <cover.1450309613.git.drivshin@allworx.com>
Message-ID: <20151217.154508.505711333985621252.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "David Rivshin (Allworx)" <drivshin.allworx@gmail.com>
Date: Wed, 16 Dec 2015 23:02:08 -0500

> I have tested on the following hardware configurations:
>  - (EVMSK) dual emac with two real MDIO-connected phys using RGMII-TXID
>  - single emac with fixed-link using RGMII
> Testing of other CPSW emac configurations that folks may have would
> be appreciated.

I'm going to wait until some others give some feedback and testing
results on this one, thanks.
