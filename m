From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 11 Jul 2012 12:47:17 +0100
Subject: [PATCH v5 5/6] spi: s3c64xx: Remove the 'set_level' callback
 from controller data
In-Reply-To: <1342005359-748-1-git-send-email-thomas.abraham@linaro.org>
References: <CAJuYYwSi-1nBM40SWt359W0Lr2n_yVX5tvWfOS77bmLQRt_9fw@mail.gmail.com>
 <1342005359-748-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <20120711114716.GF3938@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2012 at 04:45:59PM +0530, Thomas Abraham wrote:
> The set_level callback in the controller data, which is used to configure
> the slave select line, cannot be supported when migrating the driver to
> device tree based discovery. Since all the platforms currently use gpio
> as the slave select line, this callback can be removed from the
> controller data and replaced with call to gpio_set_value in the driver.

I don't seem to have patches 1-4?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120711/418f6cca/attachment.sig>
