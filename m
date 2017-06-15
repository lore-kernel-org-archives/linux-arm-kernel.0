From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 15 Jun 2017 17:30:20 +0200
Subject: [PATCH net-next v5 00/11] net: mvmdio: add xMDIO xSMI support
In-Reply-To: <20170615144326.24463-1-antoine.tenart@free-electrons.com>
References: <20170615144326.24463-1-antoine.tenart@free-electrons.com>
Message-ID: <20170615153020.GC3786@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 15, 2017 at 04:43:15PM +0200, Antoine Tenart wrote:
> Hello,
> 
> This series aims to add the xSMI support on the xMDIO bus to the
> mvmdio driver. The xSMI interface complies with the IEEE 802.3 clause 45
> and is used by 10GbE devices. On 7k and 8k (as of now), such an
> interface is found and is used by Ethernet controllers.
> 
> Patches 1-4 and 9 are cosmetic cleanups.
> 
> Patches 5-7 are prerequisites to the xSMI support.
> 
> Patches 8 and 10-11 add the xSMI support to the mvmdio driver, and a
> node is added both in the cp110 slave and master device trees.
> 
> This was tested on an Armada 8040 mcbin, as well as on both the
> Armada 7040 DB and the Armada 8040 DB to ensure the SMI interface
> was still working.
> 
> @Dave: patch 11 should go through the mvebu tree as asked by Gregory,
> thanks!
> 
> Thanks,
> Antoine

Looks good.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
