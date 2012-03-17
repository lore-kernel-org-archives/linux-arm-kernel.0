From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 17 Mar 2012 21:30:23 +0000
Subject: [PATCH 2/5] MMC: mmci: Seperate ARM variants from generic code
In-Reply-To: <201203161248.15490.arnd@arndb.de>
References: <1331734803-17954-1-git-send-email-lee.jones@linaro.org>
 <201203151823.32882.arnd@arndb.de>
 <20120315203037.GA2311@n2100.arm.linux.org.uk>
 <201203161248.15490.arnd@arndb.de>
Message-ID: <20120317213022.GE3315@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2012 at 12:48:15PM +0000, Arnd Bergmann wrote:
> On Thursday 15 March 2012, Russell King - ARM Linux wrote:

> > We _do_ need a solution for GPIO-controlled voltage regulators, as these
> > are actually quite common - see the various soc-common using PCMCIA
> > drivers.

> > So I think actually a bit more thought is required here, and there's a
> > need to use some of the facilities such as regulator which are now present
> > that weren't when the driver was originally written some 9 years ago.

> Ok. Let's see what Mark has to say about this.

There's the gpio-regulator driver in mainline which should be able to
support a fairly wide range of these simple regulators, and also the
fixed voltage regulator for extremely simple cases.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120317/90d2d093/attachment-0001.sig>
