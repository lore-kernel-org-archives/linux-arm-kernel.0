From: broonie@kernel.org (Mark Brown)
Date: Wed, 19 Jun 2013 19:21:21 +0100
Subject: [PATCH v1 1/3] spi: s3c64xx: added support for polling mode
In-Reply-To: <1369032694-13183-2-git-send-email-ks.giri@samsung.com>
References: <1369032694-13183-1-git-send-email-ks.giri@samsung.com>
 <1369032694-13183-2-git-send-email-ks.giri@samsung.com>
Message-ID: <20130619182121.GC1403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 20, 2013 at 12:21:32PM +0530, Girish K S wrote:
> From: Girish K S <girishks2000@gmail.com>

> The 64xx spi driver supports partial polling mode.
> Only the last chunk of the transfer length is transferred
> or recieved in polling mode.

Applied, though I will send a followup since:

> +static u32 wait_for_timeout(struct s3c64xx_spi_driver_data *sdd,
> +					int timeout_ms)

...this function name is way too generic.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130619/52cc8385/attachment.sig>
