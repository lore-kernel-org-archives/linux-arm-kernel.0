From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 17 Dec 2012 18:24:14 +0000 (UTC)
Subject: [PATCH 1/2] ARM: OMAP3: PRCM: Fix incorrect read of reset sources
In-Reply-To: <1355765191-21545-1-git-send-email-ivan.khoronzhuk@ti.com>
References: <1355765191-21545-1-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <alpine.DEB.2.00.1212171823020.29833@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Mon, 17 Dec 2012, Ivan Khoronzhuk wrote:

> The flag mask are incorrect, so fix it.
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>

arch/arm/mach-omap2/prcm.c no longer exists in current mainline; please 
rebase this against Linus' current tree.


- Paul
