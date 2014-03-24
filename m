From: horms@verge.net.au (Simon Horman)
Date: Mon, 24 Mar 2014 11:02:16 +0900
Subject: [PATCH] ARM: shmobile: r8a7778/bockw: Move "select
 RENESAS_INTC_IRQPIN" under SoC
In-Reply-To: <1395603378-32199-1-git-send-email-geert@linux-m68k.org>
References: <1395603378-32199-1-git-send-email-geert@linux-m68k.org>
Message-ID: <20140324020216.GE8777@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 23, 2014 at 08:36:18PM +0100, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> 
> Move the "select RENESAS_INTC_IRQPIN" from the two bockw-specific sections
> to the one r8a7778-specific section, like is done for the other SoCs.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Thanks, I have queued-up this patch.
