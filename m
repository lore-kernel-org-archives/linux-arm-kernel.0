From: Haikun.Wang@freescale.com (Wang Haikun)
Date: Fri, 17 Jul 2015 09:00:43 +0000
Subject: [PATCH v2] arm: configs: Add Freescale LS1021A defconfig
References: <1435321164-48981-1-git-send-email-haikun.wang@freescale.com>
Message-ID: <DM2PR0301MB06239861D12EF29194B99F76F8980@DM2PR0301MB0623.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/26/2015 8:23 PM, Haikun Wang wrote:
> Add Freescale LS1021A initial defconfig file.
> The LS1021A SoC is a dual-core Cortex-A7 based processor.
>
> LS1021A has some special configure options against common V7 SOCs,
> such as CONFIG_THUMB2_KERNEL, CONFIG_VMSPLIT_2G, CONFIG_VFP...
>
> Enable I2C, LPUART, eDMA, WDT default.
> LS1021AQDS and LS1021ATWR boot successfully with patch.
> Above IPs also been verified successfully.
>
> Signed-off-by: Haikun Wang <haikun.wang@freescale.com>
+ yao yuan

Best regards,
Wang Haikun
