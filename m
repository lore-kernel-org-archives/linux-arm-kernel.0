From: davem@davemloft.net (David Miller)
Date: Tue, 29 Oct 2013 18:54:50 -0400 (EDT)
Subject: [PATCH v3 0/4] Fix MDIO bus timeout issues on Dreamplug
In-Reply-To: <cover.1383038973.git.leigh@solinno.co.uk>
References: <cover.1382637156.git.leigh@solinno.co.uk>
 <cover.1383038973.git.leigh@solinno.co.uk>
Message-ID: <20131029.185450.1734537211071455991.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Leigh Brown <leigh@solinno.co.uk>
Date: Tue, 29 Oct 2013 09:33:30 +0000

> I think I have addressed all comments.
> 
> Changes since v2:
>  - Fix coding style in ordio_mdio_wait_ready, as identified by David
>  - Remove un-needed operator change in orion_mdio_write, as identified by David
> 
> This patchset fixes an issue with the Dreamplug MDIO bus timeout since the
> mv643xx_eth driver was converted to use the mvmdio driver to access the bus.

Series applied to net-next, thanks.
