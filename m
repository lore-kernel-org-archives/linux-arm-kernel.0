From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sat, 25 Jan 2014 13:57:47 -0300
Subject: [PATCH v4 00/18] Armada 370/XP watchdog support
In-Reply-To: <1390431915-5115-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390431915-5115-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20140125165746.GB12189@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 22, 2014 at 08:04:57PM -0300, Ezequiel Garcia wrote:
[..]
> 
> Thanks to everyone who has helped reviewing the previous sets! It's certainly
> easier to move forward when you get so much nice feedback...
> 
> Ezequiel Garcia (18):
>   ARM: Introduce atomic MMIO modify
>   clocksource: orion: Use atomic access for shared registers
>   watchdog: orion: Add clock error handling
>   watchdog: orion: Use atomic access for shared registers
>   watchdog: orion: Remove unused macros
>   watchdog: orion: Make sure the watchdog is initially stopped
>   watchdog: orion: Handle IRQ
>   watchdog: orion: Make RSTOUT register a separate resource
>   watchdog: orion: Remove unneeded BRIDGE_CAUSE clear
>   watchdog: orion: Introduce an orion_watchdog device structure
>   watchdog: orion: Introduce per-compatible of_device_id data
>   watchdog: orion: Add per-compatible clock initialization
>   watchdog: orion: Add per-compatible watchdog start implementation
>   watchdog: orion: Add support for Armada 370 and Armada XP SoC
>   ARM: mvebu: Enable Armada 370/XP watchdog in the devicetree
>   ARM: kirkwood: Add RSTOUT 'reg' entry to devicetree
>   watchdog: orion: Enable the build on ARCH_MVEBU
>   ARM: mvebu: Enable watchdog support in defconfig
> 
[..]

If at all possible I'd like to get some acks or reviews from the people
that has followed, reviewed and discussed this series with me.

Jason, Arnd, Andrew?
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
