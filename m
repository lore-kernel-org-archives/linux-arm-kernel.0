From: broonie@kernel.org (Mark Brown)
Date: Tue, 17 Apr 2018 11:02:24 +0100
Subject: [PATCH 4/6] spi: spi-s3c64xx: Do not ignore timeout errors in
 polling I/O mode
In-Reply-To: <20180416154021.25626-4-s.nawrocki@samsung.com>
References: <20180416154021.25626-1-s.nawrocki@samsung.com>
 <CGME20180416154130epcas1p492c86e911db645acf32d960281e8b297@epcas1p4.samsung.com>
 <20180416154021.25626-4-s.nawrocki@samsung.com>
Message-ID: <20180417100224.GA8973@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 16, 2018 at 05:40:19PM +0200, Sylwester Nawrocki wrote:
> Currently timeout errors in polling I/O mode transfer are silently ignored.
> Fix it by returning an error when we time out waiting on the RX FIFO level
> to reach the transfer length.

This would probably have been better sent as a fix before the cosmetic
updates.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180417/f8e2d91c/attachment.sig>
