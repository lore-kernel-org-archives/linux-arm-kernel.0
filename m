From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 6 Jul 2017 10:01:43 +0100
Subject: [PATCH] arm64: dts: marvell: mcbin: Enable PCIe interface
In-Reply-To: <874luqf2ym.fsf@free-electrons.com>
References: <20170705161333.9315-1-gregory.clement@free-electrons.com>
 <20170705171607.GG4902@n2100.armlinux.org.uk>
 <874luqf2ym.fsf@free-electrons.com>
Message-ID: <20170706090143.GI4902@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 06, 2017 at 09:18:25AM +0200, Gregory CLEMENT wrote:
> Hi Russell King,
>
> Actually everything is available in the linux-next branch since one or
> two weeks. So you can rebase and send your series right now.

As there are multiple trees, just specifying a branch is not helpful.
The Xenon SDHCI and ethernet changes were being published through the
MISL tree, but that tree has no for-next branch.

There is no git tree specified in MAINTAINERS either.

So, sorry, I've no idea which tree you're referring to.

And no, I do _not_ want to grab a copy of linux-next to rebase my
changes on and publish back to SolidRun for their use, that would be
insane.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
