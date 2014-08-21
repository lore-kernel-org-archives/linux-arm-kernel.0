From: broonie@kernel.org (Mark Brown)
Date: Thu, 21 Aug 2014 13:10:15 -0500
Subject: [PATCH 1/2] spi: davinci: fix SPI_NO_CS functionality
In-Reply-To: <1408634706-5762-2-git-send-email-grygorii.strashko@ti.com>
References: <1408634706-5762-1-git-send-email-grygorii.strashko@ti.com>
 <1408634706-5762-2-git-send-email-grygorii.strashko@ti.com>
Message-ID: <20140821181015.GL24407@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 21, 2014 at 06:25:05PM +0300, Grygorii Strashko wrote:
> The driver should not touch CS lines if SPI_NO_CS flag is set.
> This patch fixes it as this functionality was broken accidentally
> by
> commit a88e34ea213e1b ("spi: davinci: add support to configure gpio cs through dt").

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140821/07768d23/attachment.sig>
