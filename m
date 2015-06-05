From: wxt@rock-chips.com (Caesar Wang)
Date: Sat,  6 Jun 2015 01:05:20 +0800
Subject: [PATCH v4 0/3]     ARM: rockchip: fix the SMP
Message-ID: <1433523923-4755-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

    Verified on url =
    https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-3.14


Caesar Wang (3):
  ARM: rockchip: fix the CPU soft reset
  ARM: rockchip: ensure CPU to enter WFI/WFE state
  ARM: rockchip: fix the SMP code style

 arch/arm/mach-rockchip/platsmp.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

-- 
1.9.1
