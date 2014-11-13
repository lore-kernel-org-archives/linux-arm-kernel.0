From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 13 Nov 2014 09:03:14 +0100
Subject: [PATCH 1/5] ARM: mvebu: re-enable SDHCI driver for Armada 38x
 SoC in v7 defconfig
In-Reply-To: <1415835600-97188-2-git-send-email-mw@semihalf.com>
References: <1415835600-97188-1-git-send-email-mw@semihalf.com>
 <1415835600-97188-2-git-send-email-mw@semihalf.com>
Message-ID: <20141113090314.0baf7d46@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Marcin Wojtas,

On Thu, 13 Nov 2014 00:39:56 +0100, Marcin Wojtas wrote:
> In the recent update of mvebu_v7_defconfig a config that enables sdhci-pxav3
> driver, that supports SDHCI interface of Armada 38x SoC, disappeared.
> 
> This commit enables CONFIG_MMC_SDHCI_PXAV3 back.
> 
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Fixes fc9fa8714a75 ("ARM: mvebu: update v7 defconfig with useful options")

Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
