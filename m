From: broonie@kernel.org (Mark Brown)
Date: Fri, 18 Oct 2013 00:33:04 +0100
Subject: [PATCH] spi/s3c64xx: Add missing pm_runtime_set_active() call in
 probe()
In-Reply-To: <1382026006-15544-1-git-send-email-k.kozlowski@samsung.com>
References: <1382026006-15544-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20131017233304.GU2443@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 17, 2013 at 06:06:46PM +0200, Krzysztof Kozlowski wrote:
> Mark device as PM runtime active during initialization to reflect
> actual device power/clocks state. This reduces the enable count for SPI
> bus controller gate clock so it can be disabled when the bus controller
> is not used.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131018/0edf3b9e/attachment.sig>
