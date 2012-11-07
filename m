From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 7 Nov 2012 09:23:25 +0100
Subject: [PATCH] spi: s3c64xx: Add fix for crash in spi suspend/resume
In-Reply-To: <1352268612-9671-1-git-send-email-ch.naveen@samsung.com>
References: <1352268612-9671-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <20121107082324.GA12323@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 07, 2012 at 11:40:12AM +0530, Naveen Krishna Chatradhi wrote:
> From: Abhilash Kesavan <a.kesavan@samsung.com>
> 
> The SPI driver makes a gpio_request during initialization. The requested
> gpios need to be populated as part of the s3c64xx_spi_driver_data so that
> they can be released during suspend and requested again during resume.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121107/8043c2a9/attachment-0001.sig>
