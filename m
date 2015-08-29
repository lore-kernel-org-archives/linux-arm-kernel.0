From: broonie@kernel.org (Mark Brown)
Date: Sat, 29 Aug 2015 10:35:48 +0100
Subject: [PATCH v3 0/4] regmap: i2c block support
In-Reply-To: <1440657872-24554-1-git-send-email-mpa@pengutronix.de>
References: <1440657872-24554-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20150829093548.GY12027@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 27, 2015 at 08:44:28AM +0200, Markus Pargmann wrote:
> Hi,
> 
> This series adds support for i2c block read/writes. To support the maximum 32
> byte read/write operations, the regmap core is extended by max_raw_read and
> max_raw_write. bulk operations are splitted depending of the size of
> max_raw_read/write.

...and reverted because it broke the build, probably because it was not
a patch against current development trees:

  http://kernelci.org/build/broonie-regmap/kernel/v4.2-rc8-34-gd535ae53edec/

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150829/ab2985c7/attachment.sig>
