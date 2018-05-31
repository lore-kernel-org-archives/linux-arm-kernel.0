From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Thu, 31 May 2018 21:34:03 +0530
Subject: [PULL REQUEST] arm: Actions DT for v4.18
Message-ID: <20180531160403.GA16640@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andreas,

Here is the pull request for Devicetree and Maintainer changes for the Actions
platform as suggested by Linus Walleij. Relevant drivers are already applied
by the respective subsystem maintainers.

Please pull it in!

PS: I haven't added the SPS patches since it is not yet reviewed by you.

Thanks,
Mani

The following changes since commit ee7ffc878fdedd82831df81af6ec334daff9decb:

  Add linux-next specific files for 20180530 (2018-05-30 21:42:04 +1000)

are available in the git repository at:

  git://git.linaro.org/people/manivannan.sadhasivam/linux.git s900-for-next

for you to fetch changes up to b2a2e190e41c92e10aec8440c4207efc8abd0643:

  MAINTAINERS: Add Actions Semi S900 clk entries (2018-05-31 15:17:34 +0530)

----------------------------------------------------------------
Manivannan Sadhasivam (8):
      arm64: dts: actions: Add S900 clock management unit nodes
      arm64: dts: actions: Source CMU clock for UART5
      arm64: dts: actions: Add pinctrl node for S900
      arm64: actions: Enable PINCTRL in platforms Kconfig
      MAINTAINERS: Add reviewer for ACTIONS platforms
      arm64: dts: actions: Add gpio properties to pinctrl node for S900
      arm64: dts: actions: Add gpio line names to Bubblegum-96 board
      MAINTAINERS: Add Actions Semi S900 clk entries

 MAINTAINERS                                       |   3 +
 arch/arm64/Kconfig.platforms                      |   1 +
 arch/arm64/boot/dts/actions/s900-bubblegum-96.dts | 183 +++++++++++++++++++++-
 arch/arm64/boot/dts/actions/s900.dtsi             |  29 ++++
 4 files changed, 209 insertions(+), 7 deletions(-)
