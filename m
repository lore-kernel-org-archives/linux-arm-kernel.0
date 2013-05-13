From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 13 May 2013 12:01:38 -0400
Subject: [PATCH] Kirkwood: Enable PCIe port 1 on QNAP TS-11x/TS-21x
In-Reply-To: <20130429173022.GS32497@titan.lakedaemon.net>
References: <20130421152802.GA1408@jirafa.cyrius.com>
 <20130421154704.GV2824@lunn.ch>
 <20130421161400.GD26943@jirafa.cyrius.com>
 <20130429173022.GS32497@titan.lakedaemon.net>
Message-ID: <20130513160138.GO31290@titan.lakedaemon.net>
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

mvebu-next/fixes is now mvebu/fixes and has been rebased onto
mvebu/fixes.  This patch is included.

thx,

Jason.
