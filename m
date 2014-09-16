From: broonie@kernel.org (Mark Brown)
Date: Tue, 16 Sep 2014 11:34:31 -0700
Subject: [PATCH v2] spi: pl022: Add support for chip select extension
In-Reply-To: <1410781132-16223-1-git-send-email-anders.berg@avagotech.com>
References: <1410781132-16223-1-git-send-email-anders.berg@avagotech.com>
Message-ID: <20140916183431.GX7960@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 15, 2014 at 01:38:52PM +0200, Anders Berg wrote:

> v2:
>     - added constant to <linux/amba/bus.h>

Since you're editing the AMBA code you should also CC Russell so he can
review the AMBA part of the change.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140916/8c829fa0/attachment.sig>
