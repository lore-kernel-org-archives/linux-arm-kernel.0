From: Haikun.Wang@freescale.com (Wang Haikun)
Date: Fri, 10 Jul 2015 05:08:16 +0000
Subject: [PATCH v2] arm: configs: Add Freescale LS1021A defconfig
References: <1435321164-48981-1-git-send-email-haikun.wang@freescale.com>
Message-ID: <BN1PR0301MB06122C5E07CF2423E5D83BEAF89F0@BN1PR0301MB0612.namprd03.prod.outlook.com>
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
> ---
Hi Arnd,

We are working on pushing LS1021A platform to upstream.
This patch is the base of our subsequent patches.
And it blocks the upstream process of IPs of LS1021A.
So we pay very close attention to this patch.
Please help review this patch.

Best regards,
Wang Haikun
