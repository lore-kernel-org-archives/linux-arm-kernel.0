From: broonie@kernel.org (Mark Brown)
Date: Wed, 8 Nov 2017 19:26:33 +0000
Subject: [PATCH v4 1/3] spi: imx: GPIO chip select DT property should not
 be required
In-Reply-To: <20171106194618.9421-2-tpiepho@impinj.com>
References: <20171106194618.9421-1-tpiepho@impinj.com>
 <20171106194618.9421-2-tpiepho@impinj.com>
Message-ID: <20171108192633.ssbepmaebzjooa42@sirena.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 06, 2017 at 11:46:16AM -0800, Trent Piepho wrote:
> The driver will fail to load if the device tree property for gpio chip
> selects is not specified.  Change the driver to make the property optional.
> Also have the driver respect the "num-cs" property in the standard way.

This doesn't apply against current code, please check and resend.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171108/f368c6ae/attachment.sig>
