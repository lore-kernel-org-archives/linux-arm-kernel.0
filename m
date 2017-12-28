From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 28 Dec 2017 14:32:48 +0800
Subject: [GIT PULL 3/3] Allwinner arm64 defconfig changes for 4.16
In-Reply-To: <20171228062444.GA3883@wens.csie.org>
Message-ID: <20171228063248.GA4228@wens.csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-config64-for-4.16

for you to fetch changes up to 051db633571b10c7112be00df83d5aee8d0f706e:

  arm64: defconfig: enable MUSB HDRC along with Allwinner glue (2017-12-07 09:46:13 +0100)

----------------------------------------------------------------
Allwinner arm64 defconfig changes for 4.16

Enables MUSB driver and the Allwinner glue layer driver by default.

All Allwinner SoCs (excluding the A80) have the Mentor Graphics Inventra
Multi-Point Hi-Speed OTG Controller (MHDRC). Enabling this extends test
coverage to this peripheral.

----------------------------------------------------------------
Jagan Teki (1):
      arm64: defconfig: enable MUSB HDRC along with Allwinner glue

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171228/a519efd5/attachment.sig>
