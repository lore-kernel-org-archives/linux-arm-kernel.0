From: wxt@rock-chips.com (Caesar Wang)
Date: Fri,  5 Jun 2015 12:47:54 +0800
Subject: [PATCH 0/3]     ARM: rockchip: fix the SMP
Message-ID: <1433479677-18086-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

    Verified on url =
    https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-3.14


Caesar Wang (3):
  ARM: rockchip: fix the CPU soft reset
  ARM: rockchip: ensure CPU to enter WIF state
  ARM: rockchip: fix the SMP code style

 arch/arm/mach-rockchip/platsmp.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

-- 
1.9.1
