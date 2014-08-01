From: broonie@kernel.org (Mark Brown)
Date: Fri, 1 Aug 2014 19:21:10 +0100
Subject: [PATCH v2 1/2] spi: davinci: add support to configure gpio cs
 through dt
In-Reply-To: <1406911233-18999-2-git-send-email-grygorii.strashko@ti.com>
References: <1406911233-18999-1-git-send-email-grygorii.strashko@ti.com>
 <1406911233-18999-2-git-send-email-grygorii.strashko@ti.com>
Message-ID: <20140801182110.GI30458@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 01, 2014 at 07:40:32PM +0300, Grygorii Strashko wrote:
> From: Murali Karicheri <m-karicheri2@ti.com>
> 
> Currently driver supports only configuration of GPIO CS through
> platform data. This patch enhances the driver to configure GPIO
> CS through DT. Also update the DT binding documentation to
> reflect the availability of cs-gpios.

Applied both, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140801/954f6c9a/attachment.sig>
