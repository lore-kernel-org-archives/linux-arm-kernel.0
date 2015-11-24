From: broonie@kernel.org (Mark Brown)
Date: Tue, 24 Nov 2015 13:05:23 +0000
Subject: [PATCH v2] spi: mediatek: revise mtk_spi_probe() failure flow
In-Reply-To: <1448332712-29039-1-git-send-email-leilk.liu@mediatek.com>
References: <1448332712-29039-1-git-send-email-leilk.liu@mediatek.com>
Message-ID: <20151124130523.GM1929@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2015 at 10:38:32AM +0800, Leilk Liu wrote:
> This patch revises failure flow while pm_runtime_enable().

This still doesn't explain what the purpose of this change is.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151124/235219c6/attachment.sig>
