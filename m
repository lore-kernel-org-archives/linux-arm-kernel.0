From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 06 Jul 2017 13:38:30 +0200
Subject: [PATCH] arm64: dts: marvell: mcbin: Enable PCIe interface
In-Reply-To: <20170706090143.GI4902@n2100.armlinux.org.uk> (Russell King's
 message of "Thu, 6 Jul 2017 10:01:43 +0100")
References: <20170705161333.9315-1-gregory.clement@free-electrons.com>
 <20170705171607.GG4902@n2100.armlinux.org.uk>
 <874luqf2ym.fsf@free-electrons.com>
 <20170706090143.GI4902@n2100.armlinux.org.uk>
Message-ID: <87van5eqx5.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell King,
 
 On jeu., juil. 06 2017, Russell King - ARM Linux <linux@armlinux.org.uk> wrote:

> On Thu, Jul 06, 2017 at 09:18:25AM +0200, Gregory CLEMENT wrote:
>> Hi Russell King,
>>
>> Actually everything is available in the linux-next branch since one or
>> two weeks. So you can rebase and send your series right now.
>
> As there are multiple trees, just specifying a branch is not helpful.
> The Xenon SDHCI and ethernet changes were being published through the
> MISL tree, but that tree has no for-next branch.
>
> There is no git tree specified in MAINTAINERS either.
>
> So, sorry, I've no idea which tree you're referring to.
>
> And no, I do _not_ want to grab a copy of linux-next to rebase my

Well for upstreaming I don't see the problem to base on a linux-net tags
such as next-20170704. We do it often when we submit patches to various
subsystem (and if it is not a next tag we merge various branch by
ourselves).

> changes on and publish back to SolidRun for their use, that would be
> insane.

We also deliver stable branch for various customers and in this case we
just have a different branch or tree.

However, I think we have exactly what meets your requirements:
https://github.com/MISL-EBU-System-SW/mainline-public/tree/4.12-rc6/backports

It is a stable branch which gathers most of the patch submitted for
Armada 37xx, 7K and 8K.

Gregory

>
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
