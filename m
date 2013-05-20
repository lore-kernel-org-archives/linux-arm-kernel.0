From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 20 May 2013 13:51:54 -0400
Subject: [PATCH] arm: mvebu: enable the third USB interface on
 OpenBlocks AX3
In-Reply-To: <1368720444-29357-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1368720444-29357-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130520175154.GB31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 16, 2013 at 06:07:24PM +0200, Thomas Petazzoni wrote:
> Besides the two "classic" USB interfaces with normal USB ports on the
> front side, the PlatHome OpenBlocks AX3 uses the third USB interface
> of the Marvell SoC in the mini-PCIe connector. This allows certain
> mini-PCIe cards to expose parts of their functionality as a USB
> peripheral.
> 
> This commit enables this third USB interface in the OpenBlocks AX3
> Device Tree, and also adds comments on top of the two other USB
> interfaces so that the Device Tree makes it clear which USB interface
> at the SoC level matches which USB interface visible on the board.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts |    9 +++++++++
>  1 file changed, 9 insertions(+)

Applied to mvebu/dt with Willy's and Mr. Yamagata's Tested-by's

thx,

Jason.
