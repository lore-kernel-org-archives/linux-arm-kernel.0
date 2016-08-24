From: guodong.xu@linaro.org (Guodong Xu)
Date: Wed, 24 Aug 2016 10:42:04 +0800
Subject: [PATCH v2 0/3] arm64: defconfig: enable various configs for HiKey
Message-ID: <1472006527-30620-1-git-send-email-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable various configs for HiKey, including:
1. HiSilicon Kirin DRM
2. ADV7533
3. HiSi Powerkey
4. Bluetooth

v2:
 - Removed CMA size 128M change. Leave that in bootloader as suggested by
   Thierry Reding <treding@nvidia.com>

Guodong Xu (3):
  arm64: defconfig: Enable HiSilicon kirin drm, adv7533 for HiKey
  arm64: defconfig: enable CONFIG_INPUT_HISI_POWERKEY for HiKey
  arm64: defconfig: enable bluetooth supports as modules

 arch/arm64/configs/defconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

-- 
1.9.1
