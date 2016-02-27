From: xuwei5@hisilicon.com (Wei Xu)
Date: Sat, 27 Feb 2016 17:47:10 +0800
Subject: [GIT PULL]Hisilicon Hip05 SoC defconfig updates for 4.6
Message-ID: <56D1709E.90109@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Hi Olof, Hi Kevin,

Please help to pull the following changes.
Thanks!

Best Regards,
Wei

---

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://github.com/hisilicon/linux-hisi.git tags/hip05-config-for-4.6

for you to fetch changes up to c966f0521db49f561d18820107654b0895c1c394:

  arm64: defconfig: Enable DesignWare APB GPIO controller (2016-02-25 21:21:26 +0800)

----------------------------------------------------------------
ARM64: Hip05: configure updates for 4.6

- Enable DesignWare APB GPIO controller

----------------------------------------------------------------
Kefeng Wang (1):
      arm64: defconfig: Enable DesignWare APB GPIO controller

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)
