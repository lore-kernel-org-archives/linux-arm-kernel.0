From: broonie@kernel.org (Mark Brown)
Date: Mon, 2 Jun 2014 13:35:22 +0100
Subject: [PATCH 2/2] clkdev: Export clk_register_clkdev
In-Reply-To: <1401738379-4107-3-git-send-email-chiau.ee.chew@intel.com>
References: <1401738379-4107-1-git-send-email-chiau.ee.chew@intel.com>
 <1401738379-4107-3-git-send-email-chiau.ee.chew@intel.com>
Message-ID: <20140602123522.GB31751@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 03, 2014 at 03:46:19AM +0800, Chew Chiau Ee wrote:
> From: Darren Hart <dvhart@linux.intel.com>
> 
> Allow spi-pxa2xx-pci with common clock framework support to build as a
> module by exporting clk_register_clkdev.

This needs to be patch 1 in the series not patch 2 since the change to
the driver to use the exported symbol depends on this rather than the
other way around.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140602/22ba96e0/attachment.sig>
