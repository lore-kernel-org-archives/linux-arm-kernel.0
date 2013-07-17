From: broonie@kernel.org (Mark Brown)
Date: Wed, 17 Jul 2013 09:10:41 +0100
Subject: [PATCH v3 5/7] spi: atmel: prepare clk before calling enable
In-Reply-To: <1373987782-24463-1-git-send-email-b.brezillon@overkiz.com>
References: <1373986995-23899-1-git-send-email-b.brezillon@overkiz.com>
 <1373987782-24463-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <20130717081041.GZ22506@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 16, 2013 at 05:16:22PM +0200, Boris BREZILLON wrote:
> Replace clk_enable/disable with clk_prepare_enable/disable_unprepare to
> avoid common clk framework warnings.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130717/58069644/attachment.sig>
