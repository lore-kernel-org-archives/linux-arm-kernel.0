From: broonie@kernel.org (Mark Brown)
Date: Mon, 26 Feb 2018 13:12:07 +0000
Subject: [PATCH v2 01/10] regmap: mmio: Add function to attach a clock
In-Reply-To: <1155920db000d014fd1cd604ed48d1b9a8f64ac1.1519204731.git-series.maxime.ripard@bootlin.com>
References: <cover.68c39205c8726547449e3df67b549d89380e51a2.1519204731.git-series.maxime.ripard@bootlin.com>
 <1155920db000d014fd1cd604ed48d1b9a8f64ac1.1519204731.git-series.maxime.ripard@bootlin.com>
Message-ID: <20180226131207.GB6681@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 21, 2018 at 10:20:25AM +0100, Maxime Ripard wrote:
> From: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> regmap_init_mmio_clk allows to specify a clock that needs to be enabled
> while accessing the registers.

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/mmio-clk-config

for you to fetch changes up to 31895662f9ba81e8ea9ef05abf8edcb29d4b9c18:

  regmap: mmio: Add function to attach a clock (2018-02-26 11:05:44 +0000)

----------------------------------------------------------------
regmap: MMIO regmap clock configuration

This patch provides a mechanism for specifying a different clock to be
used with the regmap clock integration.

----------------------------------------------------------------
Maxime Ripard (1):
      regmap: mmio: Add function to attach a clock

 drivers/base/regmap/regmap-mmio.c | 24 ++++++++++++++++++++++++
 include/linux/regmap.h            |  3 +++
 2 files changed, 27 insertions(+)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180226/1cab3bf5/attachment.sig>
