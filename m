From: bones@secretlab.ca (John Bonesio)
Date: Fri, 27 May 2011 13:56:58 -0700
Subject: [RFC 0/2] ARM: Tegra: Device Tree: Audio
Message-ID: <20110527205444.21000.90209.stgit@riker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is continuing work to get board specific devices initialized
from device tree nodes rather than using the current static platform_device
registration.

This patch series is for comments only. It is not intended to be submitted as a
patch at this time. I am looking for comments on the overall approach.

This series is based upon an earlier RFC series I submitted around May 11th
beginning with, "[RFC 0/3] ARM: Tegra: Device Tree: i2c & wm8903".
I haven't yet addressed the replies to that earlier series, but I intend to.

I am also aware that some of these files have changed since I've started on
this work. I haven't yet rebased to the latest.

---

John Bonesio (2):
      ARM:Tegra: Device Tree Support: Initialize the audio card from the device tree.
      ARM:Tegra: Device Tree Support: Initialize audio card gpio's from the device tree.


 arch/arm/boot/dts/tegra-harmony.dts |   10 ++++++++
 arch/arm/mach-tegra/board-dt.c      |    3 ++
 sound/soc/codecs/wm8903.c           |    5 ++++
 sound/soc/tegra/harmony.c           |   46 ++++++++++++++++++++++++++++++++---
 4 files changed, 60 insertions(+), 4 deletions(-)

-- 
- John
