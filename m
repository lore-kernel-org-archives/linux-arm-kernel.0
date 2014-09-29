From: mika.westerberg@intel.com (Mika Westerberg)
Date: Mon, 29 Sep 2014 12:57:04 +0300
Subject: [PATCH 2/2 v2] SPI: spi-pxa2xx: SPI support for Intel Quark X1000
In-Reply-To: <1412000548-9908-3-git-send-email-alvin.chen@intel.com>
References: <1412000548-9908-1-git-send-email-alvin.chen@intel.com>
 <1412000548-9908-3-git-send-email-alvin.chen@intel.com>
Message-ID: <20140929095704.GF1786@lahna.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 29, 2014 at 07:22:28AM -0700, Weike Chen wrote:
> There are two SPI controllers exported by PCI subsystem for Intel Quark X1000.
> The SPI memory mapped I/O registers supported by Quark are different from
> the current implementation, and Quark only supports the registers of 'SSCR0',
> 'SSCR1', 'SSSR', 'SSDR', and 'DDS_RATE'. This patch is to enable the SPI for
> Intel Quark X1000.
> 
> This piece of work is derived from Dan O'Donovan's initial work for Intel Quark
> X1000 SPI enabling.
> 
> Signed-off-by: Weike Chen <alvin.chen@intel.com>

Same here, please fix the minor issues pointed out by Andy and then you
can add,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
