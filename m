From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 11 Feb 2016 11:08:38 +0000
Subject: [PATCH 01/14] mfd: intel_quark_i2c_gpio: Use clkdev_create()
In-Reply-To: <1454982341-22715-2-git-send-email-sboyd@codeaurora.org>
References: <1454982341-22715-1-git-send-email-sboyd@codeaurora.org>
 <1454982341-22715-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <20160211110838.GI3782@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen,

The upstream patch.  Enjoy!

The following changes since commit 36f90b0a2ddd60823fe193a85e60ff1906c2a9b3:

  Linux 4.5-rc2 (2016-01-31 18:12:16 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-clk-v4.6

for you to fetch changes up to c4726abce63bf9b1887ce68fdf012a823bd94ec3:

  mfd: intel_quark_i2c_gpio: Use clkdev_create() (2016-02-11 11:03:07 +0000)

----------------------------------------------------------------
Immutable branch between MFD and Clk due for v4.6

----------------------------------------------------------------
Stephen Boyd (1):
      mfd: intel_quark_i2c_gpio: Use clkdev_create()

 drivers/mfd/intel_quark_i2c_gpio.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
