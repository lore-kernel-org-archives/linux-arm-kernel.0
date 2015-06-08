From: wxt@rock-chips.com (Caesar Wang)
Date: Mon,  8 Jun 2015 15:11:33 +0800
Subject: [PATCH v5 0/3] ARM: rockchip: fix the SMP
Message-ID: <1433747496-7642-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Verified on url =
    https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-3.14
Tested by 176000 cycles are pass with CPU up/dowm test scripts.


Caesar Wang (3):
  ARM: rockchip: fix the CPU soft reset
  ARM: rockchip: ensure CPU to enter WFI/WFE state
  ARM: rockchip: fix the SMP code style

 arch/arm/mach-rockchip/platsmp.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

-- 
1.9.1
