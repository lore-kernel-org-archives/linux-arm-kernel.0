From: broonie@kernel.org (Mark Brown)
Date: Thu, 16 Oct 2014 11:32:38 +0200
Subject: [PATCH v2] spi/atmel: add support for runtime PM
In-Reply-To: <1413451390-22859-1-git-send-email-wenyou.yang@atmel.com>
References: <1413451390-22859-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20141016093237.GA2200@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 16, 2014 at 05:23:10PM +0800, Wenyou Yang wrote:
> Drivers should put the device into low power states proactively whenever the
> device is not in use. Thus implement support for runtime PM and use the
> autosuspend feature to make sure that we can still perform well in case we see
> lots of SPI traffic within short period of time.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141016/d721c843/attachment.sig>
