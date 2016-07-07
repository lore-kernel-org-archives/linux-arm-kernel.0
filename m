From: xuwei5@hisilicon.com (Wei Xu)
Date: Thu, 7 Jul 2016 14:51:44 +0100
Subject: [GIT PULL]arm64: dts: hisilicon: hi6220 updates for 4.8(#2)
Message-ID: <577E5E70.1050304@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Hi Olof, Hi Kevin,

I know the walkaround for this kind of patch is still under discussion.
Could you please consider to pull the following changes?

This depends on the change in clk tree (clk-hi6220-rtc)
which is already in the clk-next.

And for easier grepping through history, below is the pull request
for the dts specific change (no clk commits):

Thanks!

Best Regards,
Wei

---

The following changes since commit 6fb924dc9c482557ebd41f6c6a5fde34210a2e08:

  clk: hi6220: Add RTC clock for pl031 (2016-06-30 12:11:49 -0700)

are available in the git repository at:

  git://github.com/hisilicon/linux-hisi.git tags/hi6220-dt-for-4.8-2

for you to fetch changes up to 810bd15fe0f049233ce6b89e1fbfaaff124be8c2:

  arm64: dts: hi6220: Add pl031 RTC support (2016-07-07 14:05:34 +0100)

----------------------------------------------------------------
ARM64: DT: Hisilicon Hi6220 updates for 4.8

- Add pl031 rtc0 and rtc1 support for hi6220 SoC

----------------------------------------------------------------
Zhangfei Gao (1):
      arm64: dts: hi6220: Add pl031 RTC support

 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
