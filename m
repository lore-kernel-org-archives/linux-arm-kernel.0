From: broonie@kernel.org (Mark Brown)
Date: Thu, 28 Nov 2013 11:22:35 +0000
Subject: [PATCH] spi/pxa2xx: Restore private register bits.
In-Reply-To: <1385662391-27573-1-git-send-email-chiau.ee.chew@intel.com>
References: <1385662391-27573-1-git-send-email-chiau.ee.chew@intel.com>
Message-ID: <20131128112235.GA27568@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 29, 2013 at 02:13:11AM +0800, Chew Chiau Ee wrote:
> From: Chew, Chiau Ee <chiau.ee.chew@intel.com>
> 
> The Intel LPSS SPI private register bits have to be restored
> when system resume from S3 suspend.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131128/30551490/attachment-0001.sig>
