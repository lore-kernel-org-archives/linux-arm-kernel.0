From: guodong.xu@linaro.org (Guodong Xu)
Date: Fri, 19 Aug 2016 23:42:04 +0800
Subject: [PATCH 0/4] arm64: defconfig: enable various configs for HiKey
Message-ID: <1471621328-21102-1-git-send-email-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable various configs for HiKey, including:
1. HiSilicon Kirin DRM
2. ADV7533
3. Powerkey
4. Bluetooth

Also, set CMA heap size to 128MB.

Guodong Xu (3):
  arm64: defconfig: Enable HiSilicon kirin drm, adv7533 for HiKey
  arm64: defconfig: enable CONFIG_INPUT_HISI_POWERKEY for HiKey
  arm64: defconfig: enable bluetooth supports as modules

Xinliang Liu (1):
  arm64: defconfig: Set cma heap size to 128MB

 arch/arm64/configs/defconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

-- 
1.9.1
