From: broonie@kernel.org (Mark Brown)
Date: Wed, 11 Sep 2013 16:51:45 +0100
Subject: [PATCH v2 9/9] spi: attach/detach SPI device to the ACPI power
 domain
In-Reply-To: <1378913560-2752-10-git-send-email-mika.westerberg@linux.intel.com>
References: <1378913560-2752-1-git-send-email-mika.westerberg@linux.intel.com>
 <1378913560-2752-10-git-send-email-mika.westerberg@linux.intel.com>
Message-ID: <20130911155145.GX29403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 11, 2013 at 06:32:40PM +0300, Mika Westerberg wrote:
> If the SPI device is enumerated from ACPI namespace (it has an ACPI handle)
> it might have ACPI methods that needs to be called in order to transition
> the device to different power states (such as _PSx).

Acked-by: Mark Brown <broonie@linaro.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130911/00bff913/attachment.sig>
