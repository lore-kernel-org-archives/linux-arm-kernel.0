From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 21 Dec 2015 15:41:54 +0100
Subject: [PATCH 0/2] Armada 388 GP minor fixes
Message-ID: <1450708916-15966-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Here are two minor fixes/improvements to the support of the Armada 388
GP platform.

The first patch was already sent in June and July this year, but was
left on the side because it was part of a larger patch series about
suspend/resume on Armada 38x, which has not been fully merged
yet. However, this patch is completely independent from
suspend/resume, so it can be merged.

Thanks,

Thomas

Thomas Petazzoni (2):
  ARM: mvebu: adjust board name and compatible for Armada 388 GP
  ARM: mvebu: use regulator-boot-on on Armada 388 GP

 arch/arm/boot/dts/armada-388-gp.dts | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

-- 
2.6.4
