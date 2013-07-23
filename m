From: broonie@kernel.org (Mark Brown)
Date: Tue, 23 Jul 2013 18:34:54 +0100
Subject: [PATCH 01/15] drivers: phy: add generic PHY framework
In-Reply-To: <Pine.LNX.4.44L0.1307231017290.1304-100000@iolanthe.rowland.org>
References: <3419798.aorxYv8pdo@flatron>
 <Pine.LNX.4.44L0.1307231017290.1304-100000@iolanthe.rowland.org>
Message-ID: <20130723173454.GK9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 23, 2013 at 10:37:05AM -0400, Alan Stern wrote:
> On Tue, 23 Jul 2013, Tomasz Figa wrote:

> > > > Okay.  Are PHYs _always_ platform devices?

> > > They can be i2c, spi or any other device types as well.

> In those other cases, presumably there is no platform data associated
> with the PHY since it isn't a platform device.  Then how does the
> kernel know which controller is attached to the PHY?  Is this spelled
> out in platform data associated with the PHY's i2c/spi/whatever parent?

Platform data is nothing to do with the platform bus - it's board
specific data (ie, data for the platform) and can be done with any
device.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130723/9aafc3b9/attachment-0001.sig>
