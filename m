From: hector.oron@gmail.com (Hector Oron)
Date: Tue, 30 Aug 2011 11:43:29 +0100
Subject: [PATCH V7 1/5] AHCI Add the AHCI SATA feature on the MX53
	platforms
In-Reply-To: <1314698171-7937-1-git-send-email-richard.zhu@linaro.org>
References: <1314698171-7937-1-git-send-email-richard.zhu@linaro.org>
Message-ID: <CAODfWeEm8bkySXxb1qopbH1VMu-V+33k5x+0+qjABzesT0amOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

2011/8/30 Richard Zhu <richard.zhu@linaro.org>:
> Signed-off-by: Richard Zhu <richard.zhu@linaro.org>
> ---
> ?arch/arm/mach-mx5/clock-mx51-mx53.c ? ? ? ? ? ? | ? 19 ++++
> ?arch/arm/mach-mx5/devices-imx53.h ? ? ? ? ? ? ? | ? ?4 +
> ?arch/arm/plat-mxc/Makefile ? ? ? ? ? ? ? ? ? ? ?| ? ?1 +
> ?arch/arm/plat-mxc/ahci_sata.c ? ? ? ? ? ? ? ? ? | ?104 +++++++++++++++++++++++
> ?arch/arm/plat-mxc/devices/Kconfig ? ? ? ? ? ? ? | ? ?4 +
> ?arch/arm/plat-mxc/devices/Makefile ? ? ? ? ? ? ?| ? ?1 +
> ?arch/arm/plat-mxc/devices/platform-ahci-imx.c ? | ? 66 ++++++++++++++
> ?arch/arm/plat-mxc/include/mach/ahci_sata.h ? ? ?| ? 33 +++++++
> ?arch/arm/plat-mxc/include/mach/devices-common.h | ? 10 ++
> ?9 files changed, 242 insertions(+), 0 deletions(-)
> ?create mode 100644 arch/arm/plat-mxc/ahci_sata.c
> ?create mode 100644 arch/arm/plat-mxc/devices/platform-ahci-imx.c
> ?create mode 100644 arch/arm/plat-mxc/include/mach/ahci_sata.h

The good news are that I have tested this patch series on i.MX53 LOCO
board and it seems to work fine here. Thanks.


Tested-By: Hector Oron Martinez <hector.oron@gmail.com>

-- 
?H?ctor Or?n ?-.. . -... .. .- -. ? -.. . ...- . .-.. --- .--. . .-.
