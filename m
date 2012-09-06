From: koba@kmckk.co.jp (Tetsuyuki Kobayshi)
Date: Thu,  6 Sep 2012 20:14:05 +0900
Subject: [PATCH v3 0/2] ARM: shmobile: enable PMU(Performance Monitoring Unit)
In-Reply-To: <50487370.6000409@kmckk.co.jp>
References: <50487370.6000409@kmckk.co.jp>
Message-ID: <1346930047-9541-1-git-send-email-koba@kmckk.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>

Hello, Will

Could you apply this patch set to your pmu/cleanup branch on arm-soc?

The follewing patches enables PMU(Performance Monitoring Unit) for sh73a0 and emev2 SoCs. I tested these patches on kzm9g board and kzm9d board.

Tetsuyuki Kobayashi (2):
  ARM: shmobile: sh73a0: enable PMU(Performance Monitoring Unit)
  ARM: shmobile: emev2: enable PMU(Performance Monitoring Unit)

 arch/arm/configs/kzm9d_defconfig      |    1 +
 arch/arm/configs/kzm9g_defconfig      |    1 +
 arch/arm/mach-shmobile/setup-emev2.c  |   21 +++++++++++++++++++++
 arch/arm/mach-shmobile/setup-sh73a0.c |   21 +++++++++++++++++++++
 4 files changed, 44 insertions(+)

-- 
1.7.9.5
