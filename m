From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 29 Apr 2013 20:03:38 +0200
Subject: [PATCH] Kirkwood: Enable PCIe port 1 on QNAP TS-11x/TS-21x
In-Reply-To: <20130429173022.GS32497@titan.lakedaemon.net>
References: <20130421152802.GA1408@jirafa.cyrius.com>
 <20130421154704.GV2824@lunn.ch>
 <20130421161400.GD26943@jirafa.cyrius.com>
 <20130429173022.GS32497@titan.lakedaemon.net>
Message-ID: <20130429180338.GE16725@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 29, 2013 at 01:30:22PM -0400, Jason Cooper wrote:
> On Sun, Apr 21, 2013 at 05:14:00PM +0100, Martin Michlmayr wrote:
> > Enable KW_PCIE1 on QNAP TS-11x/TS-21x devices as newer revisions
> > (rev 1.3) have a USB 3.0 chip from Etron on PCIe port 1.  Thanks
> > to Marek Vasut for identifying this issue!
> > 
> > Cc: <stable@kernel.org>
> > Signed-off-by: Martin Michlmayr <tbm@cyrius.com>
> > Tested-by: Marek Vasut <marex@denx.de>
> 
> Applied to mvebu-next/fixes.  This branch will be rebased onto v3.10-rc1
> once it drops.  I'll submit a pull request then.
> 
> fyi: looks like this can be applied to stable all the way back to
> v2.6.36.x, updated stable tag accordingly.

Hi Jason

Once we have v3.10-rc1 with the DT PCI patches, i will also make an
update to them to enable both PCI ports where available.

We should also change the kirkwood_defconfig to enable the PCI USB
3.0. driver. I can do that as well.

       Andrew
