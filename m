From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 May 2015 17:35:37 +0200
Subject: [PATCH v1] arm: configs: Add Freescale LS1021A defconfig
In-Reply-To: <1431951726-10992-1-git-send-email-haikun.wang@freescale.com>
References: <1431951726-10992-1-git-send-email-haikun.wang@freescale.com>
Message-ID: <6265444.OllNdeKdQh@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 May 2015 20:22:06 Haikun Wang wrote:
> Add Freescale LS1021A initial defconfig file.
> Enable I2C, LPUART, eDMA, WDT default.
> LS1021AQDS and LS1021ATWR boot successfully with patch.
> Above IPs also been verified successfully.
> 
> Signed-off-by: Haikun Wang <haikun.wang@freescale.com>
> 

Can you explain why you need a separate defconfig, aside from imx_v6_v7_defconfig
and multi_v7_defconfig? Please put a reason into the description above,
as we normally try to have only one defconfig per machine directory.

Does this machine require LPAE to function correctly?

	Arnd
