From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 04 Jan 2017 17:31:05 +0100
Subject: [PATCH 0/5] ARM: dts: armada388: rework clearfog's .dtsi
 references
In-Reply-To: <E1cO4UH-0008SR-GW@rmk-PC.armlinux.org.uk> (Russell King's
 message of "Mon, 02 Jan 2017 15:25:25 +0000")
References: <E1cO454-00083C-Tj@rmk-PC.armlinux.org.uk>
 <E1cO4UH-0008SR-GW@rmk-PC.armlinux.org.uk>
Message-ID: <87wpeaeqie.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,
 
 On lun., janv. 02 2017, Russell King <rmk+kernel@armlinux.org.uk> wrote:

> This patch series, based upon the previous series adding Clearfog Base
> support, reworks the clearfog .dtsi file to reference nodes by label
> rather than by path.
>
> Not everything is moved - just those which had labels at the time the
> patches were created.

All the series is applied on mvebu/dt, however I would like to have a
commit log for the first patch before pushing it to arm-soc.

Thanks,

Gregory


>
>  arch/arm/boot/dts/armada-388-clearfog-base.dts     |  15 +
>  arch/arm/boot/dts/armada-388-clearfog.dtsi         | 353 ++++++++++-----------
>  .../arm/boot/dts/armada-38x-solidrun-microsom.dtsi | 113 ++++---
>  3 files changed, 245 insertions(+), 236 deletions(-)

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
