From: richard.zhuhongxing@gmail.com (Richard Zhu)
Date: Mon, 17 Jun 2013 17:52:44 +0800
Subject: [PATCH V1 0/3] ahci: enable ahci sata support on imx6q
Message-ID: <1371462767-16630-1-git-send-email-r65037@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v1: add imx6q specific ahci sata support to arch/arm/mach-imx/mach-imx6q.c

These patches is based on imx/dt branch of
"http://git.linaro.org/git-ro/people/shawnguo/linux-2.6.git"

[v1 1/3] ARM: dtsi: enable ahci sata on imx6q platforms
[v1 2/3] ata: ahci_platform: enable imx6q ahci sata support
[v1 3/3] imx: ahci: enable ahci sata on imx6q platforms
