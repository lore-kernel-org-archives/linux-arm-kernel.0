From: broonie@kernel.org (Mark Brown)
Date: Fri, 18 Oct 2013 00:34:36 +0100
Subject: [PATCH] spi: spi-s3c64xx: Add missing pm_runtime_put on setup fail
In-Reply-To: <1382013941-861-1-git-send-email-k.kozlowski@samsung.com>
References: <1382013941-861-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20131017233436.GV2443@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 17, 2013 at 02:45:41PM +0200, Krzysztof Kozlowski wrote:
> pm_runtime_put() wasn't called if clock rate could not be set up in
> s3c64xx_spi_setup() leading to invalid count of device pm_runtime usage.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131018/ba324d2d/attachment.sig>
