From: broonie@kernel.org (Mark Brown)
Date: Wed, 14 Nov 2018 14:22:15 -0800
Subject: [PATCH v6 1/6] regmap: add a new macro:REGMAP_IRQ_REG_LINE(_id,
 _reg_bits)
In-Reply-To: <1540894081-31270-2-git-send-email-tony.xie@rock-chips.com>
References: <1540894081-31270-1-git-send-email-tony.xie@rock-chips.com>
 <1540894081-31270-2-git-send-email-tony.xie@rock-chips.com>
Message-ID: <20181114222215.GD2089@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 30, 2018 at 06:07:56PM +0800, Tony Xie wrote:
> if there are lots of irqs for a device and the register addresses for these
> irqs is continuous, we can use this macro to initialize regmap_irq value.

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-irq-line

for you to fetch changes up to 43fac3238c1d9363b2a93d8d56c2be0c29c64e6c:

  regmap: add a new macro:REGMAP_IRQ_REG_LINE(_id, _reg_bits) (2018-11-14 14:20:45 -0800)

----------------------------------------------------------------
regmap: Add an IRQ_LINE macro to help defining regmap-irq tables

----------------------------------------------------------------
Tony Xie (1):
      regmap: add a new macro:REGMAP_IRQ_REG_LINE(_id, _reg_bits)

 include/linux/regmap.h | 6 ++++++
 1 file changed, 6 insertions(+)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181114/347728f7/attachment.sig>
