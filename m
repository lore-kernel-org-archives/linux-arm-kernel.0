From: horms@verge.net.au (Simon Horman)
Date: Mon, 10 Jul 2017 10:40:11 +0200
Subject: [PATCH 0/7] ARM: dts: renesas: Add Inter Connect RAM
In-Reply-To: <1499181798-28859-1-git-send-email-geert+renesas@glider.be>
References: <1499181798-28859-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20170710084010.GJ13680@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 04, 2017 at 05:23:11PM +0200, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> R-Car Gen2 and RZ/G1 SoCs contain two or three blocks of SRAM, which can be
> used for several purposes.  One such purpose is holding a jump stub for CPU
> core bringup.
> 
> This patch series adds the SRAM blocks to the various DTS files, following
> the generic DT bindings for "mmio-sram" in
> Documentation/devicetree/bindings/sram/sram.txt.  Reserving SRAM for jump
> stub for CPU core bringup will be handled in a follow-up series.
> 
> Thanks!

Geert, these seem nice and clean to me.
Are they ready to be applied?
