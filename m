From: mika.westerberg@linux.intel.com (Mika Westerberg)
Date: Fri, 25 Jul 2014 08:32:30 +0300
Subject: [PATCH v2] spi/pxa2xx-pci: Add common clock framework support in
 PCI glue layer
In-Reply-To: <1406221854-12828-1-git-send-email-chiau.ee.chew@intel.com>
References: <1406221854-12828-1-git-send-email-chiau.ee.chew@intel.com>
Message-ID: <20140725053230.GT1857@lahna.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 25, 2014 at 01:10:54AM +0800, chiau.ee.chew at intel.com wrote:
> From: Chew, Chiau Ee <chiau.ee.chew@intel.com>
> 
> SPI PXA2XX core layer has dependency on common clock framework
> to obtain information on host supported clock rate. Thus, we
> setup the clock device in the PCI glue layer to enable PCI mode
> host pass in the clock rate information.
> 
> Signed-off-by: Chew, Chiau Ee <chiau.ee.chew@intel.com>
> Acked-by: Kweh, Hock Leong <hock.leong.kweh@intel.com>

Looks reasonable,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
