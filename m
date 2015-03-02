From: broonie@kernel.org (Mark Brown)
Date: Mon, 2 Mar 2015 17:29:07 +0000
Subject: [PATCH 06/10] ASOC: migor: use clkdev_create()
In-Reply-To: <E1YSTnc-0001Jo-1U@rmk-PC.arm.linux.org.uk>
References: <20150302170538.GQ8656@n2100.arm.linux.org.uk>
 <E1YSTnc-0001Jo-1U@rmk-PC.arm.linux.org.uk>
Message-ID: <20150302172907.GY21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 02, 2015 at 05:06:32PM +0000, Russell King wrote:
> clkdev_create() is a shorter way to write clkdev_alloc() followed by
> clkdev_add().  Use this instead.

Acked-by: Mark Brown <broonie@kernel.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150302/7ae92e76/attachment-0001.sig>
