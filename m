From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 03 Feb 2015 13:54:42 +0100
Subject: [PATCH] ARM: berlin: add a defconfig
In-Reply-To: <1422962932-12603-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1422962932-12603-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <3962783.sVjmOB1hYm@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 February 2015 12:28:52 Antoine Tenart wrote:
> Marvell Berlin SoCs did not have a custom defconfig and were only
> supported in multi_v7_defconfig.
> 
> Adds a proper defconfig, allowing to boot a Berlin SoC with all the
> currently supported features: SMP, Pinmux, AHCI, Ethernet, I2C, GPIO,
> USB, SDHCI.
> 
> 

Are there any features that are not currently supported by
multi_v7_defconfig? If so, please also add them there as
loadable modules.

	Arnd
