From: sr@denx.de (Stefan Roese)
Date: Fri, 16 Nov 2012 08:16:47 +0100
Subject: [PATCH 0/6] Add basic support for Allwinner A1X SoCs
In-Reply-To: <1353019586-21043-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1353019586-21043-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <50A5E85F.50903@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On 11/15/2012 11:46 PM, Maxime Ripard wrote:
> You'll find in this patchset the initial support for Allwinner A10 and A13 SoCs
> from Allwinner. Since the internal name of these SoCs are sun4i and sun5i, the
> mach- directory is named sunxi.
> 
> You can find these SoCs in the Cubieboard, the A13-olinuxino or the Melee
> A1000.
> 
> Both SoCs should work fine, as the A13 is a trimmed down version of the A10,
> but it has only been tested on a A13-OlinuXino from Olimex.
> 
> Support is quite minimal for now, since it only includes timer and IRQ
> controller drivers, so we can only boot to userspace through initramfs. Support
> for the other peripherals on these SoCs will come eventually.

Great, thanks!

I've been working on upstreaming sunxi support as well in the last days.
You were a bit faster. :) Here is my latest port, for review on the
linux-sunxi list:

https://groups.google.com/forum/#!topic/linux-sunxi/H4ct05OmYtQ

(sorry about this google list)

I'll review your patches soon and send some comments.

Thanks,
Stefan
