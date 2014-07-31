From: broonie@kernel.org (Mark Brown)
Date: Thu, 31 Jul 2014 20:35:46 +0100
Subject: [PATCH 1/2] spi: davinci: fix to support more than 2 chip selects
In-Reply-To: <1406827995-30913-2-git-send-email-grygorii.strashko@ti.com>
References: <1406827995-30913-1-git-send-email-grygorii.strashko@ti.com>
 <1406827995-30913-2-git-send-email-grygorii.strashko@ti.com>
Message-ID: <20140731193546.GP17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 31, 2014 at 08:33:14PM +0300, Grygorii Strashko wrote:
> From: Murali Karicheri <m-karicheri2@ti.com>
> 
> Currently, the driver defines SPI_MAX_CHIPSELECT as 2 and
> use per device array bytes_per_word based on this. This breaks
> if num_chipselect per device is greater than 2. This patch
> fix this and allocate memory for this array based on
> num_chipselect.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140731/cfb4f923/attachment.sig>
