From: broonie@kernel.org (Mark Brown)
Date: Thu, 12 Sep 2013 10:31:45 +0100
Subject: [PATCH v2 8/9] spi: prepare runtime PM support for SPI devices
In-Reply-To: <20130912092743.GK7393@intel.com>
References: <1378913560-2752-1-git-send-email-mika.westerberg@linux.intel.com>
 <1378913560-2752-9-git-send-email-mika.westerberg@linux.intel.com>
 <20130911155120.GW29403@sirena.org.uk>
 <20130912092743.GK7393@intel.com>
Message-ID: <20130912093145.GA29403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 12, 2013 at 12:27:43PM +0300, Mika Westerberg wrote:
> On Wed, Sep 11, 2013 at 04:51:20PM +0100, Mark Brown wrote:

> > I would be able to have this and the other patch in the SPI tree in case
> > it overlaps with other work - I'm not sure what the plan will be for
> > merging this stuff but if there were a branch which I could merge into
> > the SPI tree that'd be good.

> I think these two can go via your SPI tree as they shouldn't have
> dependencies to the I2C tree.

There's all the driver changes though - it seems best to push the whole
series through one branch so there's fewer bisection problems.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130912/a01fec21/attachment.sig>
