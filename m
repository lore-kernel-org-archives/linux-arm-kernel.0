From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 12 Sep 2016 17:52:30 +0200
Subject: [GIT PULL] ARM: mediatek: soc updates for v4.9
Message-ID: <dd55c369-3684-2a27-6b66-7a98fa485627@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Please pull the following change.

Thanks,
Matthias

----

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

   Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

   https://github.com/mbgg/linux-mediatek.git tags/v4.8-next-soc

for you to fetch changes up to e180f887ba40a916153e29e6ad48c34d28966740:

   soc: mediatek: PMIC wrap: Extend the waiting time to 10ms. 
(2016-08-22 19:31:36 +0200)

----------------------------------------------------------------
- extent the waiting time of the pmic wrapper to 10 ms which
reduces the failure rate on the data transfer between pmic and
pmic wrapper.

----------------------------------------------------------------
Henry Chen (1):
       soc: mediatek: PMIC wrap: Extend the waiting time to 10ms.

  drivers/soc/mediatek/mtk-pmic-wrap.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)
