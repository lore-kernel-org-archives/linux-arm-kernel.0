From: gmbnomis@gmail.com (Simon Baatz)
Date: Tue, 24 Jul 2018 20:36:15 +0200
Subject: [PATCH] ARM: dts: sun8i: r40/v40: rewrite BPi M2 Berry DTS to
 rebase on M2 Ultra
In-Reply-To: <20180724163655.61365-1-icenowy@aosc.io>
References: <20180724163655.61365-1-icenowy@aosc.io>
Message-ID: <20180724183613.GA10380@gandalf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 25, 2018 at 12:36:55AM +0800, Icenowy Zheng wrote:
> Banana Pi designs the BPi M2 Berry board to be software compatible with
> BPi M2 Ultra, so it's based on M2 Ultra with some function cuts,
> including:
> 
> - 2048MiB DRAM -> 1024MiB (this should be proceed by the bootloader);
> - dropped a LED;
> - dropped eMMC;
> - dropped USB2 and connect USB1 to a 4-port HUB.
> 
> Thus we can make the M2 Berry device tree based on the M2 Ultra, rather
> than write one from scratch.

Good idea!  I know that Ultra came first and then the cut-down Berry. 
But from a device tree point of view, wouldn't it make more sense to
take M2 Berry as the base and just add the hardware for M2 Ultra?
