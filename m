From: broonie@kernel.org (Mark Brown)
Date: Sat, 5 Oct 2013 11:31:06 +0100
Subject: [PATCH v4] i2c: enable runtime PM for I2C adapter devices
 enumerated from ACPI
In-Reply-To: <20131005080901.GQ28875@intel.com>
References: <1380552228-23329-2-git-send-email-mika.westerberg@linux.intel.com>
 <1380632982-10709-1-git-send-email-mika.westerberg@linux.intel.com>
 <20131005080901.GQ28875@intel.com>
Message-ID: <20131005103106.GX27287@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 05, 2013 at 11:09:01AM +0300, Mika Westerberg wrote:

> It looks like Windows actually powers the I2C controller off independently
> of the I2C client power state. We should probably do the same in Linux even
> though it is not following what the ACPI spec says (but makes sense with
> serial buses like I2C and SPI).

Sounds like it's probably worth going to the effort of getting the spec
amended...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131005/d387696f/attachment.sig>
