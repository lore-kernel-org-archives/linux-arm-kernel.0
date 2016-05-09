From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 09 May 2016 16:38:48 +0200
Subject: [GIT PULL] ARM: dts: exynos: Non-critical fixes for v4.7
In-Reply-To: <1462619428-13798-1-git-send-email-k.kozlowski@samsung.com>
References: <1462619428-13798-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <7398428.rrnfaS9ayc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 07 May 2016 13:10:28 Krzysztof Kozlowski wrote:
> Samsung DTS non-critical fixes for v4.7:
> 1. Fix s5p-mfc driver probe on Exynos542x Peach boards (need to provide MFC
>    memory banks). On these boards this was broken for long time but
>    apparently no one enabled this driver till now.
> 2. Fix creation of debugfs entries for one regulator on Exynos4210
>    Trats board.
> 3. Fix probing of max8997 MFD driver (and its children) because
>    of missing interrupt. Actually the current version of the driver probes
>    (just without interrupts) but after switching to regmap and regmap-irq,
>    the interrupt will be mandatory.
> 
> 

Merged into next/fixes-non-critical, thanks!

	Arnd
