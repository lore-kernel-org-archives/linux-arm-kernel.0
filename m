From: olof@lixom.net (Olof Johansson)
Date: Fri, 2 Nov 2018 11:27:28 -0700
Subject: [GIT PULL] omap1 fix for v4.20 merge window
In-Reply-To: <pull-1539984133-332635@atomide.com>
References: <pull-1539984133-332635@atomide.com>
Message-ID: <20181102182728.jiggyrejbc3cf4wn@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 19, 2018 at 02:24:14PM -0700, Tony Lindgren wrote:
> From: "Tony Lindgren" <tony@atomide.com>
> 
> The following changes since commit 1137ceee76ba8b8c698e11b7150e35524f071bda:
> 
>   ARM: OMAP1: ams-delta: Don't request unused GPIOs (2018-09-20 14:24:42 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.20/omap1-fix-signed
> 
> for you to fetch changes up to ab6ead7d07ca87e3e66e6d524c8aa311732878de:
> 
>   ARM: OMAP1: ams-delta: Fix impossible .irq < 0 (2018-10-04 07:29:41 -0700)
> 
> ----------------------------------------------------------------
> Fix for omap1 ams-delta irq
> 
> We need to use IRQ_NOTCONNECTED instead of -EINVAL for
> ams_delta_modem_ports irq.

Merged, thanks!


-Olof
