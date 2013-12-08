From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 7 Dec 2013 20:18:27 -0500
Subject: [PATCHv0 0/3] ARM: mvebu: Enable NAND controller in NETGEAR
 ReadyNAS .dts files
In-Reply-To: <cover.1386370808.git.arno@natisbad.org>
References: <cover.1386370808.git.arno@natisbad.org>
Message-ID: <20131208011827.GI11251@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 07, 2013 at 12:12:53AM +0100, Arnaud Ebalard wrote:
> 
> Now that NAND controller support is available for Armada 370/XP
> (cb28e2537a6f: ARM: mvebu: Add support for NAND controller in
> Armada 370/XP), let's enable support for ReadyNAS boards.
> 
> The three commits in this series all include the partitions
> definitions specific to each ReadyNAS variant as delivered
> by NETGEAR with standard images.
> 
> As described in similar commits 2be2bc39c6f0 (ARM: mvebu: Enable
> NAND controller in Armada XP GP board) and d8c552dddfbf (ARM: 
> mvebu: Enable NAND controller in Armada 370 Mirabox),
> "marvell,keep-config" parameter is used as current support does
> not allow for setting of timing parameters yet.
> 
> Each patch has been tested on each specific device using Ezequiel's
> tree; last known bug having being fixed today.
> 
> Jason, Ezequiel, this is a v0. I do not mind at all waiting for a
> heads up to repost it later when every bit of nand support is where
> it should be.

This seems fine by me.  Once the binding are agreed upon, dts changes
can occur independent of code changes.

> Ezequiel, I have left a comment in the .dts file to indicate a lost
> reader that the last MB of last partition is in practice not
> writable.
> 
> Cheers,
> 
> a+
> 
> Arnaud Ebalard (3):
>   ARM: mvebu: Enable NAND controller in NETGEAR ReadyNAS 102 .dts file
>   ARM: mvebu: Enable NAND controller in NETGEAR ReadyNAS 104 .dts file
>   ARM: mvebu: Enable NAND controller in NETGEAR ReadyNAS 2120 .dts file
> 
>  arch/arm/boot/dts/armada-370-netgear-rn102.dts | 36 ++++++++++++++++++++++++++
>  arch/arm/boot/dts/armada-370-netgear-rn104.dts | 36 ++++++++++++++++++++++++++
>  arch/arm/boot/dts/armada-xp-netgear-rn2120.dts | 36 ++++++++++++++++++++++++++
>  3 files changed, 108 insertions(+)

Whole series applied to mvebu/dt

thx,

Jason.
