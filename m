From: broonie@kernel.org (Mark Brown)
Date: Tue, 22 Oct 2013 09:34:01 +0100
Subject: [PATCH 1/2] spi/s3c64xx: Do not ignore return value of
 spi_master_resume/suspend
In-Reply-To: <1382362971-16763-1-git-send-email-k.kozlowski@samsung.com>
References: <1382362971-16763-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20131022083401.GB20821@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 21, 2013 at 03:42:49PM +0200, Krzysztof Kozlowski wrote:
> During PM resume and suspend do not ignore the return value of
> spi_master_suspend() or spi_master_resume(). Instead pass it further.

Applied both, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131022/599a5f5e/attachment.sig>
