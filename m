From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Nov 2012 21:40:09 +0000
Subject: [PATCH] [TRIVIAL] ARM: cns3xxx: drop unnessesary symbol selection
In-Reply-To: <1352353029-2725-1-git-send-email-kaloz@openwrt.org>
References: <1352353029-2725-1-git-send-email-kaloz@openwrt.org>
Message-ID: <201211122140.09892.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 November 2012, Imre Kaloz wrote:
> ARCH_CNS3XXX already selects MIGHT_HAVE_PCI, so boards don't have to
> 
> Signed-off-by: Imre Kaloz <kaloz@openwrt.org>

Applied on next/fixes-non-critical branch, with the subject line fixup.

Thanks,

	Arnd
