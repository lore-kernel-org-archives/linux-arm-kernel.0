From: horms@verge.net.au (Simon Horman)
Date: Thu, 27 Jul 2017 17:31:26 +0200
Subject: [PATCH] ARM: shmobile: Remove ARCH_SHMOBILE_MULTI
In-Reply-To: <1500297834-7387-1-git-send-email-geert+renesas@glider.be>
References: <1500297834-7387-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20170727153125.GM16143@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 17, 2017 at 03:23:54PM +0200, Geert Uytterhoeven wrote:
> The migration from ARCH_SHMOBILE_MULTI to ARCH_RENESAS has been
> completed in v4.12 by commit 9ed2d4bc5c0c244d ("ARM: dts: renesas:
> Switch from ARCH_SHMOBILE_MULTI to ARCH_RENESAS"), so the
> ARCH_SHMOBILE_MULTI symbol can be removed.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, applied for v4.14.
