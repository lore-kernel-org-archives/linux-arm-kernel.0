From: tim.kryger@linaro.org (Tim Kryger)
Date: Thu, 5 Dec 2013 15:00:36 -0800
Subject: [PATCH 0/2] Update bcm_defconfig
Message-ID: <1386284438-11099-1-git-send-email-tim.kryger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series includes two minor updates to the bcm_defconfig that
removes an option that wasn't being used and eliminates a line that
is now unnecessary due to a change in the defaults for that option.

Tim Kryger (2):
  ARM: bcm_defconfig: CONFIG_OABI_COMPAT default off
  ARM: bcm_defconfig: Unset CONFIG_CRYPTO_ANSI_CPRNG

 arch/arm/configs/bcm_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
1.8.0.1
