From: broonie@kernel.org (Mark Brown)
Date: Tue, 17 Jun 2014 15:46:04 +0100
Subject: [PATCH v2] spi/pxa2xx: fix incorrect SW mode chipselect setting
 for BayTrail LPSS SPI
In-Reply-To: <1402675045-22460-1-git-send-email-chiau.ee.chew@intel.com>
References: <1402675045-22460-1-git-send-email-chiau.ee.chew@intel.com>
Message-ID: <20140617144604.GW5099@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 13, 2014 at 11:57:25PM +0800, Chew Chiau Ee wrote:
> From: Chew, Chiau Ee <chiau.ee.chew@intel.com>
> 
> It was observed that after module removal followed by insertion,
> the SW mode chipselect is not properly set. Thus causing transfer
> failure due to incorrect CS toggling.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140617/8431499e/attachment.sig>
