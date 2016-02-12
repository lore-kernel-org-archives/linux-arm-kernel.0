From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 12 Feb 2016 15:50:40 -0800
Subject: [PATCH 0/6] More updates for NS2 DT
In-Reply-To: <1455084651-29325-1-git-send-email-anup.patel@broadcom.com>
References: <1455084651-29325-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <56BE6FD0.3010103@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/02/16 22:10, Anup Patel wrote:
> This patchset primarily adds more DT nodes for NS2 SVK. It also does
> minor update to arch/arm64/Kconfig.platforms and adds missing DT
> bindings document for sp805 driver.
> 
> The patchset is based on v4.5-rc3 tag and is available in ns2_dt2_v1
> branch of https://github.com/Broadcom/arm64-linux.git
> 
> All patches have been tested on Broadcom NS2 SVK.
> 
> Anup Patel (5):
>   arm64: Select COMMON_CLK_IPROC, PINCTRL and GPIOLIB for iProc SoCs
>   arm64: dts: Add SDHCI DT node for NS2
>   arm64: dts: Add ARM SP804 timer DT nodes for NS2
>   dt-bindings: watchdog: Add ARM SP805 DT bindings
>   arm64: dts: Add ARM SP805 watchdog DT node for NS2
> 
> Ray Jui (1):
>   arm64: dts: Add PCIe0 and PCIe4 DT nodes for NS2

Patch 1 applied to soc-arm64/next

Patch 2-6 applied to devicetree-arm64/next, with Rob's Acked-by and the
suggested rename from wdt@ to watchdog@ that he recommended, thanks
everyone!
-- 
Florian
