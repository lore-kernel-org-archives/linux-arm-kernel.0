From: wsa-dev@sang-engineering.com (Wolfram Sang)
Date: Thu, 1 Dec 2016 23:36:21 +0100
Subject: [PATCH v7 2/4] i2c: pxa: Add support for the I2C units found in
 Armada 3700
In-Reply-To: <20161201110440.27530-3-romain.perier@free-electrons.com>
References: <20161201110440.27530-1-romain.perier@free-electrons.com>
 <20161201110440.27530-3-romain.perier@free-electrons.com>
Message-ID: <20161201223621.GC19261@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 01, 2016 at 12:04:38PM +0100, Romain Perier wrote:
> The Armada 3700 has two I2C controllers that is compliant with the I2C
> Bus Specificiation 2.1, supports multi-master and different bus speed:
> Standard mode (up to 100 KHz), Fast mode (up to 400 KHz),
> High speed mode (up to 3.4 Mhz).
> 
> This IP block has a lot of similarity with the PXA, except some register
> offsets and bitfield. This commits adds a basic support for this I2C
> unit.
> 
> Signed-off-by: Romain Perier <romain.perier@free-electrons.com>
> Tested-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161201/3672fc3c/attachment.sig>
