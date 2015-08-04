From: public_timo.s@silentcreek.de (Timo Sigurdsson)
Date: Tue,  4 Aug 2015 11:02:24 +0200 (CEST)
Subject: [PATCH v2] ARM: dts: sunxi: Add regulators for LeMaker BananaPi
In-Reply-To: <20150803094723.GD2564@lukather>
References: <1438532305-5884-1-git-send-email-public_timo.s@silentcreek.de><20150803094723.GD2564@lukather>
Message-ID: <20150804090224.4B5676C83963@dd34104.kasserver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

Maxime Ripard schrieb am 03.08.2015 11:47:
> What regulator provides the 3.3V regulator used in the rest of this DT
> then (MMC, GMAC) ?

For GMAC, there is a reg_gmac_3v3 defined in sun7i-a20-bananapi.dts [1].
MMC uses reg_vcc3v3 included from sunxi-common-regulators.dtsi. Am I
missing something? Is this not sufficient?


Thanks,

Timo

[1] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/sun7i-a20-bananapi.dts?id=v4.2-rc5#n78
