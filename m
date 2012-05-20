From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 20 May 2012 10:47:51 +0100
Subject: [PATCH v2 1/2] mfd: Add support for MAX77686.
In-Reply-To: <1337261967-26004-2-git-send-email-yadi.brar@samsung.com>
References: <1337261967-26004-1-git-send-email-yadi.brar@samsung.com>
 <1337261967-26004-2-git-send-email-yadi.brar@samsung.com>
Message-ID: <20120520094750.GB20652@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2012 at 07:09:26PM +0530, Yadwinder Singh Brar wrote:
> MAX77686 is a mulitifunction device with PMIC, RTC and Charger on chip. This
> driver provides common support for accessing the device. This is initial
> version of this driver that supports to enable the chip with its primary I2C
> bus.It also includes IRQ and device tree support for MAX77686 chip.

Reviwed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120520/03d858a5/attachment.sig>
