From: yang.shi@linaro.org (Yang Shi)
Date: Mon,  9 Nov 2015 09:43:55 -0800
Subject: [PATCH V2 0/2] arm64: cleanup FRAME_POINTER kconfig option and force
 to select it
Message-ID: <1447091037-11434-1-git-send-email-yang.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


According to the discussion on the mailing list, this version adds a new patch
to force select FRAME_POINTER for ARM64.

Change v2 --> v1:
1. Adds a new patch to force select FRAME_POINTER
2. Notes that this change adds a dependency on DEBUG_KERNEL for building with
frame pointers


Yang Shi (2):
      arm64: remove redundant FRAME_POINTER kconfig option
      arm64: force to select FRAME_POINTER

 arch/arm64/Kconfig       | 1 +
 arch/arm64/Kconfig.debug | 4 ----
 2 files changed, 1 insertion(+), 4 deletions(-)
