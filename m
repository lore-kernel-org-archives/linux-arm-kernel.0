From: m.silentcreek@gmail.com (m.silentcreek at gmail.com)
Date: Fri, 26 Jun 2015 04:45:04 -0700 (PDT)
Subject: [PATCH] Remove deprecated symbol from defconfig files
In-Reply-To: <1435238493-32614-1-git-send-email-bernhard.nortmann@web.de>
References: <1435238493-32614-1-git-send-email-bernhard.nortmann@web.de>
Message-ID: <95d82090-1522-4ec3-ae68-dcd65d090e53@googlegroups.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 25. Juni 2015 15:47:42 UTC+2 schrieb Bernhard Nortmann:
> This patch is to re-apply the changes from
> https://groups.google.com/forum/#!topic/linux-sunxi/Hhx2CR2YWhI
> 
> It removes the deprecated/obsolete symbol CONFIG_POWER_RESET_SUN6I
> from multi_v7_defconfig and sunxi_defconfig in arch/arm/configs/.
> 
> mripard's tree incorporated the changes, but they somehow didn't
> make it upstream. The symbol is still present as of v4.1.

The patch you mention is already queued up for 4.2, see:
https://git.kernel.org/cgit/linux/kernel/git/mripard/linux.git/log/?h=sunxi/defconfig-for-4.2

To my knowledge, it was never queued up for inclusion in 4.1, because the merge window was already closed then. And since it doesn't break anything (if you run 'make sunxi_defconfig' the symbol will be dropped silently), it's not applicable to the stable 4.1 updates.
