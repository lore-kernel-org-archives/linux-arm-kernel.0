From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 29 Apr 2016 15:00:28 +0200
Subject: [PATCH 0/3] arm64: marvell: few improvment for Armada 37xx device
 tree
In-Reply-To: <1461771989-15662-1-git-send-email-gregory.clement@free-electrons.com>
 (Gregory CLEMENT's message of "Wed, 27 Apr 2016 17:46:26 +0200")
References: <1461771989-15662-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <87ziscsh77.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
 
 On mer., avril 27 2016, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> Hi,
>
> This series add few improvement on the dts for Armada 37xx. First it
> send a second version of the patch from Andreas with the modification
> initially asked. I also fix the compatibility property for the xHCI
> node to conform to the documentation.
>
>

I just want to let you know that this series was already applied on
mvebu/dt64

Gregory

> Thanks,
>
> Gregory
>
> Andreas F?rber (2):
>   arm64: dts: marvell: Clean up armada-3720-db
>   arm64: dts: marvell: Rename armada-37xx USB node
>
> Gregory CLEMENT (1):
>   arm64: dts: marvell: Use a SoC-specific compatible for xHCI on
>     Armada37xx
>
>  Documentation/devicetree/bindings/usb/usb-xhci.txt |  1 +
>  arch/arm64/boot/dts/marvell/armada-3720-db.dts     | 32 ++++++++--------------
>  arch/arm64/boot/dts/marvell/armada-372x.dtsi       |  1 -
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |  7 +++--
>  4 files changed, 17 insertions(+), 24 deletions(-)
>
> -- 
> 2.5.0
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
