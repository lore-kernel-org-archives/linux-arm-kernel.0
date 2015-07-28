From: broonie@kernel.org (Mark Brown)
Date: Tue, 28 Jul 2015 15:52:41 +0100
Subject: [PATCH v2 2/2] spi: s3c64xx: add more debug prints.
In-Reply-To: <8b628c8d38c4a01f5c4657a4213984d98789d757.1438075797.git.hramrach@gmail.com>
References: <cover.1438075797.git.hramrach@gmail.com>
 <8b628c8d38c4a01f5c4657a4213984d98789d757.1438075797.git.hramrach@gmail.com>
Message-ID: <20150728145241.GE11162@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 28, 2015 at 09:37:03AM -0000, Michal Suchanek wrote:
> The SPI transfers can mysteriously fail so add more debug prints about
> SPI parameters set by the driver.
> 
> The hardware specific SPI driver is the only place where the programmed
> SPI parameters are known so there is no other reasonable place for these
> prints.

For timing things there should already be enough information in the
trace points with better resolution.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150728/88b96f41/attachment.sig>
