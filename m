From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 14 Feb 2012 09:23:43 -0800
Subject: [PATCH v2 6/9] ARM: mx31ads: add audmux device
In-Reply-To: <20120214073414.GB3276@b20223-02.ap.freescale.net>
References: <20120202091132.GD9773@S2101-09.ap.freescale.net>
 <20120202092427.GB32403@b20223-02.ap.freescale.net>
 <20120202130901.GE9773@S2101-09.ap.freescale.net>
 <20120202135805.GB3015@richard-laptop>
 <20120203021554.GE32403@b20223-02.ap.freescale.net>
 <20120203133240.GB12915@S2101-09.ap.freescale.net>
 <a9d9bad3-edd0-4a5f-9bb3-15787430d858@email.android.com>
 <20120214013506.GA3276@b20223-02.ap.freescale.net>
 <20120214060627.GB13456@opensource.wolfsonmicro.com>
 <20120214073414.GB3276@b20223-02.ap.freescale.net>
Message-ID: <20120214172342.GA3916@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 14, 2012 at 03:34:15PM +0800, Richard Zhao wrote:
> On Mon, Feb 13, 2012 at 10:06:28PM -0800, Mark Brown wrote:

> > Machine drivers can easily get platform data, they're just regular
> > drivers of whatever type so can get platform data in the same way that
> > any other driver for their bus can.

> Machine drivers don't correspond to any hw devices. If we create a
> virtual platform device, it'll be hard for DT binding.

As has been discussed repeatedly and at some considerable length the
board design for audio is considered sufficiently interesting to be
worth representing in the device tree directly, there are plenty of
choices made during board design.  There is absolutely no technical
problem from doing this on the device tree side.

People working on device tree really need to talk to each other more...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120214/e4642b63/attachment.sig>
