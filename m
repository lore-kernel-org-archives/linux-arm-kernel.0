From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 26 Jan 2013 15:36:14 +0800
Subject: [PATCH 1/2] spi: spi-gpio: Add checks for the dt properties
In-Reply-To: <1359103175-26304-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1359103175-26304-1-git-send-email-maxime.ripard@free-electrons.com>
 <1359103175-26304-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20130126073612.GP10580@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 25, 2013 at 09:39:34AM +0100, Maxime Ripard wrote:
> The bindings assumed that the gpios properties were always there, which
> made the NO_TX and NO_RX mode not usable from device tree. Add extra
> checks to make sure that the driver can work if either MOSI or MISO is
> not used.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130126/fa7e46d4/attachment.sig>
