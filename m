From: broonie@kernel.org (Mark Brown)
Date: Sun, 28 Jul 2013 13:32:30 +0100
Subject: [PATCH v2 5/8] ARM: s3c64xx: dma: Use
 clk_prepare_enable/clk_disable_unprepare
In-Reply-To: <1374536965-3545-6-git-send-email-tomasz.figa@gmail.com>
References: <1374536965-3545-1-git-send-email-tomasz.figa@gmail.com>
 <1374536965-3545-6-git-send-email-tomasz.figa@gmail.com>
Message-ID: <20130728123230.GR9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 23, 2013 at 01:49:22AM +0200, Tomasz Figa wrote:
> This patch modifies s3c64xx DMA driver to prepare and unprepare clocks
> in addition to enableind and disabling, since it is required by common
> clock framework.

Tested-by: Mark Brown <broonie@linaro.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130728/b997499b/attachment.sig>
