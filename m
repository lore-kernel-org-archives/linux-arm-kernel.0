From: broonie@kernel.org (Mark Brown)
Date: Fri, 6 Jun 2014 10:52:56 +0100
Subject: [PATCH] spi/pxa2xx: change default supported DMA burst size to 1
In-Reply-To: <1401990309-12492-1-git-send-email-chiau.ee.chew@intel.com>
References: <1401990309-12492-1-git-send-email-chiau.ee.chew@intel.com>
Message-ID: <20140606095256.GA2520@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 06, 2014 at 01:45:09AM +0800, Chew Chiau Ee wrote:
> From: Chew, Chiau Ee <chiau.ee.chew@intel.com>
> 
> This is to fix the SPI DMA transfer failure for speed less than 1M.
> If using current DMA burst size setting (16), the Rx data bytes are
> invalid due to each data byte is multiplied according to the burst
> size setting.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140606/851c658f/attachment.sig>
