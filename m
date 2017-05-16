From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 16 May 2017 11:14:55 +0200
Subject: [GIT PULL] Meson Kconfig fixes for 4.12-rc1
Message-ID: <3059c91b-034c-3da3-9ca4-06ad11bcec42@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike, Stephen,

Here is a single fix for the Meson Kconfig, that could go for 4.12-rc2.

Thanks,
Neil

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://github.com/baylibre/clk-meson.git tags/meson-clk-fixes-for-4.12-rc2

for you to fetch changes up to dbed87a9d3a857a86f602775b5845f5f6d9652b5:

  clk: meson: gxbb: fix build error without RESET_CONTROLLER (2017-05-16 11:05:01 +0200)

----------------------------------------------------------------
KConfig fix:
- clk: meson: gxbb: fix build error without RESET_CONTROLLER

----------------------------------------------------------------
Tobias Regnery (1):
      clk: meson: gxbb: fix build error without RESET_CONTROLLER

 drivers/clk/meson/Kconfig | 1 +
 1 file changed, 1 insertion(+)
