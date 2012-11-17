From: sr@denx.de (Stefan Roese)
Date: Sat, 17 Nov 2012 07:16:35 +0100
Subject: [PATCHv2 0/7] Add basic support for Allwinner A1X SoCs
In-Reply-To: <1353100828-9218-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1353100828-9218-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <50A72BC3.9030608@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/16/2012 10:20 PM, Maxime Ripard wrote:
> Hi,
> 
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

Nice work. Thanks. Whole series is:

Acked-by: Stefan Roese <sr@denx.de>

I'll send some A10/cubieboard patches beginning next week.

Thanks,
Stefan
