From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 27 Sep 2017 23:25:41 +0200
Subject: [GIT PULL] DTS updates for the Integrator PCIv3 driver
In-Reply-To: <CACRpkdZ0X1OiC6gogxD9EGkoMbY2yy81PPyrTWU-74ego9m+vQ@mail.gmail.com>
References: <CACRpkdZ0X1OiC6gogxD9EGkoMbY2yy81PPyrTWU-74ego9m+vQ@mail.gmail.com>
Message-ID: <CACRpkdYQeOVy=g2K5dE1FErUvAGj+p+bTh8kr4uFhb-VLrXChA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 27, 2017 at 11:24 PM, Linus Walleij
<linus.walleij@linaro.org> wrote:

> Hi ARM SoC folks,
>
> these are some three patches readying the Integrator/AP device tree to work
> properly with the modernized and corrected PCIv3 driver.
>
> Please pull them in for DTS changes.

Sorry I forgot the actual pull request... sometimes I'm doing too
stupid mistakes:

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/integrator-pciv3-dts

for you to fetch changes up to afd5d2f7af33fd4a57a68bca9e651ca7fd41263b:

  ARM: dts: Update Integrator/AP PCI v3 compatible (2017-09-27 23:11:16 +0200)

----------------------------------------------------------------
These are the DTS file changes required to fix bugs and satisfy
requirements for the new PCIv3 driver in the PCI subsystem.
The binding changes have been merged to the PCI tree.

----------------------------------------------------------------
Linus Walleij (3):
      ARM: dts: add the PCI clock to the device tree
      ARM: dts: integratorap: Fix PCI windows
      ARM: dts: Update Integrator/AP PCI v3 compatible

 arch/arm/boot/dts/integratorap.dts | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)
