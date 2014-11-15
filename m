From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 14 Nov 2014 21:48:19 -0500
Subject: [PATCH v2] ARM: mvebu: re-enable SDHCI driver for Armada 38x
 SoC in v7 defconfig
In-Reply-To: <1415978967-7350-1-git-send-email-mw@semihalf.com>
References: <1415978967-7350-1-git-send-email-mw@semihalf.com>
Message-ID: <20141115024819.GM3698@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marcin,

On Fri, Nov 14, 2014 at 04:29:27PM +0100, Marcin Wojtas wrote:
> In the recent update of mvebu_v7_defconfig a config that enables sdhci-pxav3
> driver, that supports SDHCI interface of Armada 38x SoC, disappeared.
> 
> This commit enables CONFIG_MMC_SDHCI_PXAV3 back.
> 
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Fixes fc9fa8714a75 ("ARM: mvebu: update v7 defconfig with useful options")

Please don't forget to Cc the maintainers.  ;-)  No need to resend, I
have it queued up.

thx,

Jason.
