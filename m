From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 31 Jul 2014 11:51:58 +0200
Subject: [GIT PULL] Allwinner DT additions for 3.17, take 2
Message-ID: <20140731095158.GA14197@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Here are a rather small (and late) pull request for the Allwinner DTs
that comes on top of the previous one.

It's basically just a fix, so there's no real need to merge it by
-rc1, it can definitely be postponed to a later 3.17-rc.

Thanks,
Maxime

The following changes since commit c220aec2bb793bf5a1fb451fd3e4db87654c5ba5:

  ARM: dts: sun6i: Add Merrii A31 Hummingbird support (2014-07-18 22:40:37 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-dt-for-3.17-2

for you to fetch changes up to 495bccf3917b04c6727d720b56620e265c693ace:

  ARM: dt: sun6i: Add #address-cells and #size-cells to i2c controller nodes (2014-07-28 11:34:39 +0200)

----------------------------------------------------------------
Allwinner DT changes, take 2

Only a single patch in here that fixes a DTC warning.

----------------------------------------------------------------
Chen-Yu Tsai (1):
      ARM: dt: sun6i: Add #address-cells and #size-cells to i2c controller nodes

 arch/arm/boot/dts/sun6i-a31.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140731/832b5fe8/attachment.sig>
