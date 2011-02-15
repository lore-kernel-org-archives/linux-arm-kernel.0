From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 16 Feb 2011 01:20:28 +0300
Subject: [PATCH 4/4] arm: V2 configs: update pxa910 defconfig for SoC
	Selection
In-Reply-To: <5DE28962-5F04-4D34-8D65-DF4020F135CD@marvell.com>
References: <5DE28962-5F04-4D34-8D65-DF4020F135CD@marvell.com>
Message-ID: <4D5AFC2C.6010408@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16-02-2011 0:55, Philip Rakity wrote:

> V2
> ==
> Use make savedefconfigconfig to produce reduced size defconfig
> per suggestion of Nico Pitre.

> V1
> ==

    The log of the patch changes should go under the --- tear line.

> took old pxa910_defconfig --
> did make menuconfig
> changed to CPU_PXA910

> Signed-off-by: Philip Rakity<prakity@marvell.com>
> ---
>   arch/arm/configs/pxa910_defconfig |    6 +-----
>   1 files changed, 1 insertions(+), 5 deletions(-)

WBR, Sergei
