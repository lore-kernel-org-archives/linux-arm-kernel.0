From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 28 Apr 2015 19:35:21 -0700
Subject: [2/2] ARM: BCM2835: Move the restart/power_off handling to the
 WDT driver.
In-Reply-To: <1429902534-2348-2-git-send-email-eric@anholt.net>
References: <1429902534-2348-2-git-send-email-eric@anholt.net>
Message-ID: <20150429023521.GA29594@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 24, 2015 at 12:08:54PM -0700, Eric Anholt wrote:
> Since the WDT is what's used to drive restart and power off, it makes
> more sense to keep it there, where the regs are already mapped and
> definitions for them provided.  Note that this means you may need to
> add CONFIG_BCM2835_WDT to retain functionality of your kernel.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Cc: linux-watchdog at vger.kernel.org
> Acked-by: Stephen Warren <swarren@wwwdotorg.org>
> Tested-by: Stephen Warren <swarren@wwwdotorg.org>
> Acked-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Guenter Roeck <linux@roeck-us.net>
