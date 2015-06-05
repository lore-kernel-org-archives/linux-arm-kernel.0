From: wxt@rock-chips.com (Caesar Wang)
Date: Fri,  5 Jun 2015 19:39:19 +0800
Subject: [PATCH v2 0/3]     ARM: rockchip: fix the SMP
Message-ID: <1433504362-7549-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

    Verified on url =
    https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-3.14


Caesar Wang (3):
  ARM: rockchip: fix the CPU soft reset
  ARM: rockchip: ensure CPU to enter WFI/WFE state
  ARM: rockchip: fix the SMP code style

 arch/arm/mach-rockchip/platsmp.c | 56 +++++++++++++++++++++++++++-------------
 1 file changed, 38 insertions(+), 18 deletions(-)

-- 
1.9.1
