From: broonie@kernel.org (Mark Brown)
Date: Sat, 16 Aug 2014 17:20:06 -0500
Subject: [PATCH v2] spi/pxa2xx-pci: Add common clock framework support in
 PCI glue layer
In-Reply-To: <1406221854-12828-1-git-send-email-chiau.ee.chew@intel.com>
References: <1406221854-12828-1-git-send-email-chiau.ee.chew@intel.com>
Message-ID: <20140816222006.GB14537@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 25, 2014 at 01:10:54AM +0800, chiau.ee.chew at intel.com wrote:
> From: Chew, Chiau Ee <chiau.ee.chew@intel.com>
> 
> SPI PXA2XX core layer has dependency on common clock framework
> to obtain information on host supported clock rate. Thus, we
> setup the clock device in the PCI glue layer to enable PCI mode
> host pass in the clock rate information.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140816/eb77b4d6/attachment.sig>
