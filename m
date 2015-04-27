From: lkundrak@v3.sk (Lubomir Rintel)
Date: Mon, 27 Apr 2015 14:58:23 +0200
Subject: [PATCH 2/2] ARM: BCM2835: Move the restart/power_off handling
 to the WDT driver.
In-Reply-To: <1429902534-2348-2-git-send-email-eric@anholt.net>
References: <1429902534-2348-1-git-send-email-eric@anholt.net>
 <1429902534-2348-2-git-send-email-eric@anholt.net>
Message-ID: <1430139503.3948.11.camel@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-04-24 at 12:08 -0700, Eric Anholt wrote:
> Since the WDT is what's used to drive restart and power off, it makes
> more sense to keep it there, where the regs are already mapped and
> definitions for them provided.  Note that this means you may need to
> add CONFIG_BCM2835_WDT to retain functionality of your kernel.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Cc: linux-watchdog at vger.kernel.org

Acked-by: Lubomir Rintel <lkundrak@v3.sk>
