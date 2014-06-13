From: mika.westerberg@linux.intel.com (Mika Westerberg)
Date: Fri, 13 Jun 2014 16:10:08 +0300
Subject: [PATCH v2] spi/pxa2xx: fix incorrect SW mode chipselect setting
 for BayTrail LPSS SPI
In-Reply-To: <1402675045-22460-1-git-send-email-chiau.ee.chew@intel.com>
References: <1402675045-22460-1-git-send-email-chiau.ee.chew@intel.com>
Message-ID: <20140613131008.GK21178@lahna.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 13, 2014 at 11:57:25PM +0800, Chew Chiau Ee wrote:
> From: Chew, Chiau Ee <chiau.ee.chew@intel.com>
> 
> It was observed that after module removal followed by insertion,
> the SW mode chipselect is not properly set. Thus causing transfer
> failure due to incorrect CS toggling.
> 
> Signed-off-by: Chew, Chiau Ee <chiau.ee.chew@intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
